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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.router.replace(const TabRoute());
        } else if (state is LoginError) {
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
                  Text(translate(LocaleKeys.general_login)),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: translate(LocaleKeys.general_email),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: translate(LocaleKeys.general_password),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  ChecklistRoundedButton(
                      text: translate(LocaleKeys.general_login),
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;

                        BlocProvider.of<LoginCubit>(context)
                            .login(email: email, password: password);
                      }),
                  ChecklistRoundedButton(
                      text: translate(LocaleKeys.general_register),
                      onPressed: () async {}),
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
      case AuthenticationErrorType.wrong_password:
        return translate(LocaleKeys.authentication_errors_invalid_password);
      case AuthenticationErrorType.user_not_found:
        return translate(LocaleKeys.authentication_errors_user_not_found);
      case AuthenticationErrorType.user_disabled:
        return translate(LocaleKeys.authentication_errors_user_disabled);
      case AuthenticationErrorType.unknown_error:
        return translate(LocaleKeys.authentication_errors_unknown_error);
    }
  }
}
