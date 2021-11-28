import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/splash/cubit/splash_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    return BlocProvider<SplashCubit>(
      create: (context) => cubitFactory.get<SplashCubit>(),
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
    BlocProvider.of<SplashCubit>(context).initializeApplication();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is OpenHome) {
          context.router.replace(const OnboardingRoute());
        }
      },
      child: const Scaffold(body: Center(child: ChecklistLoadingIndicator())),
    );
  }
}
