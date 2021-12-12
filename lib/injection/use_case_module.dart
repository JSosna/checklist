import 'package:checklist/domain/checklists/use_case/create_checklist_use_case.dart';
import 'package:checklist/domain/checklists/use_case/delete_checklist_use_case.dart';
import 'package:checklist/domain/checklists/use_case/is_user_checklist_admin.dart';
import 'package:checklist/domain/checklists/use_case/load_checklists_use_case.dart';
import 'package:checklist/domain/checklists/use_case/update_checklist_elements_use_case.dart';
import 'package:checklist/domain/groups/use_case/add_user_to_existing_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/create_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/delete_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/get_join_code_use_case.dart';
import 'package:checklist/domain/groups/use_case/leave_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/load_detailed_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:checklist/domain/users/use_case/change_username_use_case.dart';
import 'package:checklist/domain/users/use_case/register_user_use_case.dart';
import 'package:get_it/get_it.dart';

void registerUseCaseModule(GetIt injector) {
  injector.registerFactory(() => RegisterUserUseCase(injector.get(), injector.get()));
  injector.registerFactory(() => ChangeUsernameUseCase(injector.get(), injector.get()));
  injector.registerFactory(() => LoadGroupsUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => AddUserToExistingGroupUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => CreateGroupUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => LeaveGroupUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => DeleteGroupUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => LoadDetailedGroupUseCase(injector.get(), injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => CreateChecklistUseCase(injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => LoadChecklistsUseCase(injector.get(), injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => IsUserChecklistAdminUseCase(injector.get(), injector.get()));
  injector.registerFactory(() => DeleteChecklistUseCase(injector.get(), injector.get()));
  injector.registerFactory(() => UpdateChecklistElementsUseCase(injector.get()));
  injector.registerFactory(() => GetJoinCodeUseCase(injector.get()));
}
