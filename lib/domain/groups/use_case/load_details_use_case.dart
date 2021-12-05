import 'package:checklist/domain/groups/detailed_group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LoadDetailedGroupUseCase {
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  LoadDetailedGroupUseCase(
    this._usersRepository,
    this._groupsRepository,
  );

  Future<DetailedGroup?> getDetailedGroup({required String groupId}) async {
    try {
      final group = await _groupsRepository.getGroup(groupId: groupId);
      final membersIds = group?.membersIds;

      if (group != null && membersIds != null) {
        final members = <User>[];

        for (var i = 0; i < (group.membersIds?.length ?? 0); i++) {
          final member = await _usersRepository.getUser(userId: membersIds[i]);

          if (member != null) {
            members.add(member);
          }
        }

        return DetailedGroup(group: group, members: members);
      }
    } catch (e, stack) {
      Fimber.e("Loading group details error", ex: e, stacktrace: stack);
    }
    return null;
  }
}
