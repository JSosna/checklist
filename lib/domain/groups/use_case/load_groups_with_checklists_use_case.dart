import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/group_with_checklists.dart';
import 'package:checklist/domain/groups/use_case/load_group_with_checklist_use_case.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LoadGroupsWithChecklistsUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final LoadGroupWithChecklistsUseCase _loadGroupWithChecklistsUseCase;

  LoadGroupsWithChecklistsUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._loadGroupWithChecklistsUseCase,
  );

  Future<List<GroupWithChecklists>?> getGroupsWithChecklists() async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId == null) {
        return null;
      }

      final user = await _usersRepository.getUser(userId: userId);
      final groupsIds = user?.groupsIds;

      if (groupsIds == null) {
        return null;
      }

      final groupsWithChecklists = <GroupWithChecklists>[];

      for (var i = 0; i < groupsIds.length; i++) {
        final groupWithChecklists = await _loadGroupWithChecklistsUseCase
            .getGroupWithChecklists(groupId: groupsIds[i]);

        if (groupWithChecklists != null) {
          groupsWithChecklists.add(groupWithChecklists);
        }
      }

      return groupsWithChecklists;
    } catch (e, stack) {
      Fimber.e(
        "Loading groups with checklists error",
        ex: e,
        stacktrace: stack,
      );
    }
    return null;
  }
}
