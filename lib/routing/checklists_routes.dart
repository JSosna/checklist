import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/checklists/details/checklist_details_page.dart';
import 'package:checklist/presentation/checklists/list/checklists_page.dart';
import 'package:checklist/presentation/groups/picker/group_picker_page.dart';

class ChecklistsRoutes {
  static const List<AutoRoute> items = [
    AutoRoute<dynamic>(page: ChecklistsPage, initial: true),
    AutoRoute<dynamic>(page: ChecklistDetailsPage),
    AutoRoute<dynamic>(page: GroupPickerPage),
  ];
}
