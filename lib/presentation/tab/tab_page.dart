import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/checklists/list/checklists_loader_cubit/cubit/checklists_loader_cubit.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/presentation/groups/list/groups_loader_cubit/groups_loader_cubit.dart';
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
        BlocProvider<ChecklistsLoaderCubit>(
          create: (context) => cubitFactory.get(),
        ),
        BlocProvider<ChecklistsCubit>(
          create: (context) =>
              cubitFactory.getChecklistsCubit(cubitFactory.get()),
        ),
        BlocProvider<GroupsLoaderCubit>(create: (context) => cubitFactory.get()),
        BlocProvider<GroupsCubit>(
          create: (context) => cubitFactory.getGroupsCubit(cubitFactory.get()),
        ),
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
        routes: const [ChecklistsRouter(), GroupsRouter(), SettingsRoute()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            backgroundColor: context.isDarkTheme ? Colors.black : Colors.white,
            selectedItemColor:
                context.isDarkTheme ? Colors.white : Colors.black,
            unselectedItemColor:
                context.isDarkTheme ? Colors.white54 : Colors.black54,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<ChecklistsLoaderCubit>(context)
                    .reloadChecklists();
              } else if (index == 1) {
                BlocProvider.of<GroupsLoaderCubit>(context).reloadGroups();
              }

              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_rounded),
                label: translate(LocaleKeys.tab_lists),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.groups),
                label: translate(LocaleKeys.tab_groups),
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
