import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/authentication/user.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<AuthenticationResponse> login(
      {required String email, required String password}) async {
    try {
      final user = await firebase.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (user.user != null) {
        return AuthenticationSuccess(
            user: User(
                uid: user.user?.uid,
                email: user.user?.email,
                name: user.user?.displayName));
      }
    } on firebase.FirebaseAuthException catch (e) {
      return AuthenticationError(authenticationError: _mapErrorCode(e.code));
    } catch (e, stack) {
      Fimber.e("Login error", ex: e, stacktrace: stack);
    }

    return const AuthenticationError(
        authenticationError: AuthenticationErrorType.unknown_error);
  }

  @override
  Future<AuthenticationResponse> register(
      {required String email, required String password}) async {
    try {
      final user = await firebase.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (user.user != null) {
        return AuthenticationSuccess(
            user: User(
                uid: user.user?.uid,
                email: user.user?.email,
                name: user.user?.displayName));
      }
    } on firebase.FirebaseAuthException catch (e) {
      return AuthenticationError(authenticationError: _mapErrorCode(e.code));
    } catch (e, stack) {
      Fimber.e("Register error", ex: e, stacktrace: stack);
    }

    return const AuthenticationError(
        authenticationError: AuthenticationErrorType.unknown_error);
  }

  AuthenticationErrorType _mapErrorCode(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return AuthenticationErrorType.invalid_email;
      case "user-disabled":
        return AuthenticationErrorType.user_disabled;
      case "user-not-found":
        return AuthenticationErrorType.user_not_found;
      case "wrong-password":
        return AuthenticationErrorType.wrong_password;
      case "email-already-in-use":
        return AuthenticationErrorType.email_already_in_use;
      case "weak-password":
        return AuthenticationErrorType.weak_password;
      default:
        return AuthenticationErrorType.unknown_error;
    }
  }
}
