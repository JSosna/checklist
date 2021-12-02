import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/bloc_factory.dart';
import 'package:checklist/presentation/splash/bloc/splash_bloc.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final BlocFactory blocFactory = BlocFactory.of(context);
    return BlocProvider<SplashBloc>(
      create: (context) => blocFactory.get<SplashBloc>(),
      child: this,
    );
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(InitializeApplication());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is OpenHome) {
          context.router.replace(const TabRoute());
        } else if (state is OpenLogin) {
          context.router.replace(const LoginRoute());
        }
      },
      child: const Scaffold(body: Center(child: ChecklistLoadingIndicator())),
    );
  }
}
