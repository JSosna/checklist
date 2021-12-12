import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class RemoveGroupMemberUseCase {
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  const RemoveGroupMemberUseCase(
    this._usersRepository,
    this._groupsRepository,
  );

  Future<bool> removeMember({
    required String groupId,
    required String memberId,
  }) async {
    try {
      await _groupsRepository.removeUserFromGroup(
        groupId: groupId,
        userId: memberId,
      );
      await _usersRepository.removeGroup(
        userId: memberId,
        groupId: groupId,
      );

      return true;
    } catch (e, stack) {
      Fimber.e("Removing member from group error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
