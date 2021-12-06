import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class DeleteGroupUseCase {
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;
  final ChecklistsRepository _checklistsRepository;

  const DeleteGroupUseCase(
    this._usersRepository,
    this._groupsRepository,
    this._checklistsRepository,
  );

  Future<bool> deleteGroup({required String groupId}) async {
    try {
      final group = await _groupsRepository.getGroup(groupId: groupId);

      if (group != null) {
        await removeGroupFromMembersList(group, groupId);
        await deleteGroupChecklists(group);

        await _groupsRepository.deleteGroup(groupId: groupId);

        return true;
      }
    } catch (e, stack) {
      Fimber.e("Deleting group error", ex: e, stacktrace: stack);
    }

    return false;
  }

  Future<void> removeGroupFromMembersList(Group group, String groupId) async {
    final membersIds = group.membersIds;

    for (var i = 0; i < membersIds.length; i++) {
      await _usersRepository.removeGroup(
        userId: membersIds[i],
        groupId: groupId,
      );
    }
  }

  Future<void> deleteGroupChecklists(Group group) async {
    final checklistsIds = group.checklistsIds;

    for (var i = 0; i < checklistsIds.length; i++) {
      await _checklistsRepository.deleteChecklist(
        checklistId: checklistsIds[i],
      );
    }
  }
}
