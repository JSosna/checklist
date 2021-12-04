import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class ChangeUsernameUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;

  ChangeUsernameUseCase(this._authenticationRepository, this._usersRepository);

  Future<void> changeUsername({
    required String username,
  }) async {
    try {
      await _authenticationRepository.changeUsername(username);
      final user = _authenticationRepository.getCurrentUser();

      if (user != null) {
        await _usersRepository.changeUsername(user, username);
      }
    } catch (e, stack) {
      Fimber.e("Change username error", ex: e, stacktrace: stack);
    }
  }
}
