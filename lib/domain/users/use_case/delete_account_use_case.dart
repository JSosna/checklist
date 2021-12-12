import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/use_case/delete_group_use_case.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class DeleteAccountUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final DeleteGroupUseCase _deleteGroupUseCase;

  DeleteAccountUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._deleteGroupUseCase,
  );

  Future<void> deleteAccount() async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId == null) {
        return;
      }

      final user = await _usersRepository.getUser(userId: userId);

      if (user == null) {
        return;
      }

      await _deleteGroups(user.groupsIds);
      await _usersRepository.deleteUser(userId: userId);

      _authenticationRepository.deleteUser();
    } catch (e, stack) {
      Fimber.e("Delete account error", ex: e, stacktrace: stack);
    }
  }

  Future<void> _deleteGroups(List<String>? groupsIds) async {
    if (groupsIds != null) {
      for (var i = 0; i < groupsIds.length; i++) {
        await _deleteGroupUseCase.deleteGroup(groupId: groupsIds[i]);
      }
    }
  }
}
