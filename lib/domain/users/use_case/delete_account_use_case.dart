import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/use_case/delete_group_use_case.dart';
import 'package:checklist/domain/users/users_repository.dart';

class DeleteAccountUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final DeleteGroupUseCase _deleteGroupUseCase;

  DeleteAccountUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._deleteGroupUseCase,
  );

  Future<void> deleteAccount({required String password}) async {
    final userId = _authenticationRepository.getCurrentUser()?.uid;

    if (userId == null) {
      return;
    }

    final user = await _usersRepository.getUser(userId: userId);

    if (user == null) {
      return;
    }

    await _authenticationRepository.deleteUser(password: password);
    await _deleteGroups(user.groupsIds);
    await _usersRepository.deleteUser(userId: userId);
  }

  Future<void> _deleteGroups(List<String>? groupsIds) async {
    if (groupsIds != null) {
      for (var i = 0; i < groupsIds.length; i++) {
        await _deleteGroupUseCase.deleteGroup(groupId: groupsIds[i]);
      }
    }
  }
}
