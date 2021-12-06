import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class CreateGroupUseCase {
  final GroupsRepository _groupsRepository;
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;

  const CreateGroupUseCase(
    this._groupsRepository,
    this._authenticationRepository,
    this._usersRepository,
  );

  Future<Group?> createGroup(String name) async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId != null) {
        final group = Group(
          name: name,
          adminId: userId,
        );

        final groupWithId = await _groupsRepository.createGroup(group: group);

        if (groupWithId != null) {
          final groupId = groupWithId.id;

          if (groupId != null) {
            await _usersRepository.addGroup(userId: userId, groupId: groupId);
            await _groupsRepository.addUserToGroup(
              groupId: groupId,
              userId: userId,
            );

            return groupWithId;
          }
        }
      }
    } catch (e, stack) {
      Fimber.e("Creating group error", ex: e, stacktrace: stack);
    }

    return null;
  }
}
