import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/authentication/login/cubit/login_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    return BlocProvider<LoginCubit>(
      create: (context) => cubitFactory.get<LoginCubit>(),
      child: this,
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailValidator = MultiValidator([
    RequiredValidator(
      errorText: translate(LocaleKeys.validation_email_is_required),
    ),
    EmailValidator(
      errorText: translate(LocaleKeys.validation_email_is_invalid),
    ),
  ]);

  final _passwordValidator = RequiredValidator(
    errorText: translate(LocaleKeys.validation_password_is_required),
  );

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).tryToAuthenticateUsingBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is BiometricAuthenticationSuccess) {
          context.router.replace(const TabRouter());
        } else if (state is LoginError) {
          final message = _mapLoginError(state.authenticationError);
          Fluttertoast.showToast(
            msg: message,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.kMarginExtraLargeDouble),
                  child: Column(
                    children: [
                      Text(translate(LocaleKeys.authentication_login)),
                      const SizedBox(height: Dimens.kMarginExtraLarge),
                      TextFormField(
                        controller: _emailController,
                        validator: _emailValidator,
                        decoration: InputDecoration(
                          labelText: translate(LocaleKeys.authentication_email),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: Dimens.kMarginExtraLarge),
                      TextFormField(
                        controller: _passwordController,
                        validator: _passwordValidator,
                        decoration: InputDecoration(
                          labelText:
                              translate(LocaleKeys.authentication_password),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      ChecklistRoundedButton(
                        text: translate(LocaleKeys.authentication_login),
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          if (_formKey.currentState?.validate() == true) {
                            BlocProvider.of<LoginCubit>(context)
                                .login(email: email, password: password);
                          }
                        },
                      ),
                      ChecklistRoundedButton(
                        text: translate(LocaleKeys.authentication_register),
                        onPressed: () async {
                          context.router.push(const RegisterRoute());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _mapLoginError(AuthenticationErrorType authenticationError) {
    switch (authenticationError) {
      case AuthenticationErrorType.invalidEmail:
        return translate(LocaleKeys.authentication_errors_invalid_email);
      case AuthenticationErrorType.wrongPassword:
        return translate(LocaleKeys.authentication_errors_invalid_password);
      case AuthenticationErrorType.userNotFound:
        return translate(LocaleKeys.authentication_errors_user_not_found);
      case AuthenticationErrorType.userDisabled:
        return translate(LocaleKeys.authentication_errors_user_disabled);
      default:
        return translate(LocaleKeys.authentication_errors_unknown_error);
    }
  }
}
