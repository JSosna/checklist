import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/authentication/login/cubit/login_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.kMarginExtraLargeDouble),
              child: Column(
                children: [
                  const Text("Login"),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Dimens.kMarginExtraLarge),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ChecklistRoundedButton(
                      text: "login",
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;

                        final value = await BlocProvider.of<LoginCubit>(context)
                            .login(email: email, password: password);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
