import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/checklists/list/checklists_page.dart';
import 'package:checklist/presentation/settings/settings_page.dart';
import 'package:checklist/routing/groups_routes.dart';

class TabsRoutes {
  static const List<AutoRoute> items = [
    AutoRoute(page: ChecklistsPage, initial: true),
    AutoRoute<dynamic>(
      page: EmptyRouterPage,
      name: 'GroupsRouter',
      children: GroupsRoutes.items,
    ),
    AutoRoute(page: SettingsPage),
  ];
}
