import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LeaveGroupUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  const LeaveGroupUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._groupsRepository,
  );

  Future<bool> leaveGroup({required String groupId}) async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId != null) {
        await _groupsRepository.removeUserFromGroup(
          groupId: groupId,
          userId: userId,
        );
        await _usersRepository.removeGroup(
          userId: userId,
          groupId: groupId,
        );

        return true;
      }
    } catch (e, stack) {
      Fimber.e("Loading groups error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
