import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/authentication/user.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:local_auth/local_auth.dart';

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  final LocalAuthentication localAuthentication;

  FirebaseAuthenticationRepository(this.localAuthentication);

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
      {required String username,
      required String email,
      required String password}) async {
    try {
      final user = await firebase.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (user.user != null) {
        await firebase.FirebaseAuth.instance.currentUser
            ?.updateDisplayName(username);

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

  @override
  User? getCurrentUser() {
    final user = firebase.FirebaseAuth.instance.currentUser;

    if (user != null) {
      return User(uid: user.uid, email: user.email, name: user.displayName);
    } else {
      return null;
    }
  }

  @override
  Stream<User?> userStream() async* {
    yield* firebase.FirebaseAuth.instance.authStateChanges().map((user) {
      if (user == null) {
        return null;
      } else {
        return User(uid: user.uid, email: user.email, name: user.displayName);
      }
    });
  }

  @override
  Future<void> logout() async {
    try {
      await firebase.FirebaseAuth.instance.signOut();
    } catch (e, stack) {
      Fimber.e("Logout error", ex: e, stacktrace: stack);
    }
  }

  @override
  Future<bool> canDeviceAuthenticateUsingBiometrics() async {
    return localAuthentication.canCheckBiometrics;
  }

  @override
  Future<bool> authenticateUsingBiometrics(String reason) async {
    return localAuthentication.authenticate(
        localizedReason: reason, biometricOnly: true);
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
