import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/users/user.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResponse> login({
    required String email,
    required String password,
  });

  Future<AuthenticationResponse> register({
    required String username,
    required String email,
    required String password,
  });

  User? getCurrentUser();

  Stream<User?> userStream();

  Future<void> logout();

  Future<bool> canDeviceAuthenticateUsingBiometrics();

  Future<bool> authenticateUsingBiometrics(String reason);

  Future<void> changeUsername(String newValue);

  Future<bool> deleteUser({required String password});
}
