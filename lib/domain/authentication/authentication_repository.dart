import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/authentication/user.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResponse> login(
      {required String email, required String password});

  Future<AuthenticationResponse> register(
      {required String username,
      required String email,
      required String password});

  Stream<User?> userStream();

  Future<void> logout();
}
