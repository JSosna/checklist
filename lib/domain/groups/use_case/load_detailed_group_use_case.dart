import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/detailed_group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LoadDetailedGroupUseCase {
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;
  final ChecklistsRepository _checklistsRepository;

  LoadDetailedGroupUseCase(
    this._usersRepository,
    this._groupsRepository,
    this._checklistsRepository,
  );

  Future<DetailedGroup?> getDetailedGroup({required String groupId}) async {
    try {
      final group = await _groupsRepository.getGroup(groupId: groupId);
      final membersIds = group?.membersIds;
      final checklistsIds = group?.checklistsIds;

      if (group != null && membersIds != null && checklistsIds != null) {
        final members = await _getMembers(membersIds);
        final checklists = await _getChecklists(checklistsIds);

        return DetailedGroup(
          group: group,
          members: members,
          checklists: checklists,
        );
      }
    } catch (e, stack) {
      Fimber.e("Loading group details error", ex: e, stacktrace: stack);
    }
    return null;
  }

  Future<List<User>> _getMembers(List<String> membersIds) async {
    final members = <User>[];

    for (var i = 0; i < (membersIds.length); i++) {
      final member = await _usersRepository.getUser(userId: membersIds[i]);

      if (member != null) {
        members.add(member);
      }
    }

    return members;
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
