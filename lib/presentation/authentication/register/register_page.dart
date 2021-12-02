import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/authentication/register/cubit/register_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    return BlocProvider<RegisterCubit>(
      create: (context) => cubitFactory.get<RegisterCubit>(),
      child: this,
    );
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.router.replace(const OnboardingRoute());
        } else if (state is RegisterError) {
          final message = _mapLoginError(state.authenticationError);
          Fluttertoast.showToast(
              msg: message,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.kMarginExtraLargeDouble),
              child: Column(
                children: [
                  Text(translate(LocaleKeys.authentication_register)),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: translate(LocaleKeys.authentication_username),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: translate(LocaleKeys.authentication_email),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: translate(LocaleKeys.authentication_password),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText:
                          translate(LocaleKeys.authentication_confirm_password),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  ChecklistRoundedButton(
                      text: translate(LocaleKeys.authentication_register),
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final confirmedPassword =
                            confirmPasswordController.text;

                        BlocProvider.of<RegisterCubit>(context)
                            .login(email: email, password: password);
                      }),
                  ChecklistRoundedButton(
                      text: translate(LocaleKeys.authentication_login),
                      onPressed: () async {
                        context.router.pop();
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _mapLoginError(AuthenticationErrorType authenticationError) {
    switch (authenticationError) {
      case AuthenticationErrorType.invalid_email:
        return translate(LocaleKeys.authentication_errors_invalid_email);
      case AuthenticationErrorType.email_already_in_use:
        return translate(LocaleKeys.authentication_errors_invalid_password);
      case AuthenticationErrorType.weak_password:
        return translate(LocaleKeys.authentication_errors_user_not_found);
      default:
        return translate(LocaleKeys.authentication_errors_unknown_error);
    }
  }
}
