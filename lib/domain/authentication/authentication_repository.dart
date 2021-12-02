import 'package:checklist/domain/authentication/authentication_result.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResponse> login(
      {required String email, required String password});

  Future<AuthenticationResponse> register(
      {required String username,
      required String email,
      required String password});
}
