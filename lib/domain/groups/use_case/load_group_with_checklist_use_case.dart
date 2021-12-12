import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/group_with_checklists.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class LoadGroupWithChecklistsUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ChecklistsRepository _checklistsRepository;
  final GroupsRepository _groupsRepository;

  LoadGroupWithChecklistsUseCase(
    this._authenticationRepository,
    this._checklistsRepository,
    this._groupsRepository,
  );

  Future<GroupWithChecklists?> getGroupWithChecklists({
    required String groupId,
  }) async {
    try {
      final group = await _groupsRepository.getGroup(groupId: groupId);
      final membersIds = group?.membersIds;
      final checklistsIds = group?.checklistsIds;

      if (group != null && membersIds != null && checklistsIds != null) {
        final checklists = await _getChecklists(checklistsIds);

        final currentUserId = _authenticationRepository.getCurrentUser()?.uid;

        if (currentUserId != null) {
          return GroupWithChecklists(
            group: group,
            checklists: checklists,
          );
        }
      }
    } catch (e, stack) {
      Fimber.e("Loading group with checklists error", ex: e, stacktrace: stack);
    }
    return null;
  }

  Future<List<Checklist>> _getChecklists(List<String> checklistsIds) async {
    final checklists = <Checklist>[];

    for (var i = 0; i < (checklistsIds.length); i++) {
      final checklist = await _checklistsRepository.getChecklist(
        checklistId: checklistsIds[i],
      );

      if (checklist != null) {
        checklists.add(checklist);
      }
    }

    return checklists;
  }
}
