import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extension.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/home/cubit/home_cubit.dart';
import 'package:checklist/presentation/settings/cubit/settings_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPage extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory blocFactory = CubitFactory.of(context);
    return MultiBlocProvider(providers: [
      BlocProvider<HomeCubit>(create: (context) => blocFactory.get()),
      BlocProvider<SettingsCubit>(create: (context) => blocFactory.get())
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      animationDuration: const Duration(seconds: 0),
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
                  label: translate(LocaleKeys.tab_home)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: translate(LocaleKeys.tab_settings)),
            ]);
      },
    );
  }
}
