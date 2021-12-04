import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/home/cubit/home_cubit.dart';
import 'package:checklist/presentation/tab/cubit/authentication_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPage extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => cubitFactory.get(),
        ),
        BlocProvider<HomeCubit>(create: (context) => cubitFactory.get()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is UserLoggedOut) {
          context.router.replace(const LoginRoute());
        }
      },
      child: AutoTabsScaffold(
        lazyLoad: false,
        animationDuration: Duration.zero,
        routes: const [HomeRoute(), SettingsRoute()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            selectedItemColor:
                context.isDarkTheme ? Colors.white : Colors.black,
            unselectedItemColor: Colors.grey[600],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: translate(LocaleKeys.tab_home),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: translate(LocaleKeys.tab_settings),
              ),
            ],
          );
        },
      ),
    );
  }
}
