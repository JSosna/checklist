import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class AddUserToExistingGroupUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  const AddUserToExistingGroupUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._groupsRepository,
  );

  // TODO: Handle join code valid until
  Future<bool> addUserToExistingGroup(String joinCode) async {
    try {
      final group =
          await _groupsRepository.getGroupWithJoinCode(joinCode: joinCode);
      final groupId = group?.id;
      final userId = _authenticationRepository.getCurrentUser()?.uid;
      if (userId != null && groupId != null) {
        final userComplete = await _usersRepository.getUser(userId: userId);

        if (group != null && userComplete != null) {
          if (group.membersIds?.contains(userId) == true ||
              userComplete.groupsIds?.contains(groupId) == true) {
            return false;
          }

          await _groupsRepository.addUserToGroup(
            groupId: groupId,
            userId: userId,
          );
          await _usersRepository.addGroup(userId: userId, groupId: groupId);

          return true;
        }
      }
    } catch (e, stack) {
      Fimber.e("Joining group error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
