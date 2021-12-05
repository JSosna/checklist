import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class DeleteGroupUseCase {
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  const DeleteGroupUseCase(
    this._usersRepository,
    this._groupsRepository,
  );

  Future<bool> deleteGroup({required String groupId}) async {
    try {
      final group = await _groupsRepository.getGroup(groupId: groupId);

      if (group != null) {
        final membersIds = group.membersIds;

        if (membersIds != null) {
          for (var i = 0; i < membersIds.length; i++) {
            await _usersRepository.removeGroup(
              userId: membersIds[i],
              groupId: groupId,
            );
          }

          await _groupsRepository.deleteGroup(groupId: groupId);

          return true;
        }
      }
    } catch (e, stack) {
      Fimber.e("Deleting group error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
