import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class RegisterUserUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;

  RegisterUserUseCase(this._authenticationRepository, this._usersRepository);

  Future<AuthenticationResponse> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authenticationRepository.register(
        username: username,
        email: email,
        password: password,
      );

      if (response is AuthenticationError) {
        return response;
      }

      final user = _authenticationRepository.getCurrentUser();

      if (user != null) {
        try {
          await _usersRepository.addUser(user);
          return AuthenticationSuccess(user: user);
        } catch (e, stack) {
          _authenticationRepository.logout();
          Fimber.e("Register error", ex: e, stacktrace: stack);
        }
      }
    } catch (e, stack) {
      Fimber.e("Register error", ex: e, stacktrace: stack);
    }

    return const AuthenticationError(
      authenticationErrorType: AuthenticationErrorType.unknownError,
    );
  }
}
