import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/groups/add/add_group_page.dart';
import 'package:checklist/presentation/groups/details/group_details_page.dart';
import 'package:checklist/presentation/groups/list/groups_page.dart';

class GroupsRoutes {
  static const List<AutoRoute> items = [
    AutoRoute<dynamic>(page: GroupsPage, initial: true),
    AutoRoute<dynamic>(page: GroupDetailsPage),
    AutoRoute<dynamic>(page: AddGroupPage),
  ];
}
