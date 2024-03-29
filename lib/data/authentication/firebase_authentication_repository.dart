import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:local_auth/local_auth.dart';

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  final LocalAuthentication localAuthentication;

  FirebaseAuthenticationRepository(this.localAuthentication);

  @override
  Future<AuthenticationResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebase.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (user.user != null) {
        return AuthenticationSuccess(
          user: User(
            uid: user.user?.uid,
            email: user.user?.email,
            name: user.user?.displayName,
          ),
        );
      }
    } on firebase.FirebaseAuthException catch (e) {
      return AuthenticationError(
          authenticationErrorType: _mapErrorCode(e.code));
    } catch (e, stack) {
      Fimber.e("Login error", ex: e, stacktrace: stack);
    }

    return const AuthenticationError(
      authenticationErrorType: AuthenticationErrorType.unknownError,
    );
  }

  @override
  Future<AuthenticationResponse> register({
    required String username,
    required String email,
    required String password,
  }) async {
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
            name: user.user?.displayName,
          ),
        );
      }
    } on firebase.FirebaseAuthException catch (e) {
      return AuthenticationError(
          authenticationErrorType: _mapErrorCode(e.code));
    } catch (e, stack) {
      Fimber.e("Register error", ex: e, stacktrace: stack);
    }

    return const AuthenticationError(
      authenticationErrorType: AuthenticationErrorType.unknownError,
    );
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
    try {
      return localAuthentication.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } catch (e, stack) {
      Fimber.e("Biometric auth error", ex: e, stacktrace: stack);
    }

    return false;
  }

  @override
  Future<void> changeUsername(String newValue) async {
    await firebase.FirebaseAuth.instance.currentUser
        ?.updateDisplayName(newValue);
  }

  AuthenticationErrorType _mapErrorCode(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return AuthenticationErrorType.invalidEmail;
      case "user-disabled":
        return AuthenticationErrorType.userDisabled;
      case "user-not-found":
        return AuthenticationErrorType.userNotFound;
      case "wrong-password":
        return AuthenticationErrorType.wrongPassword;
      case "email-already-in-use":
        return AuthenticationErrorType.emailAlreadyInUse;
      case "weak-password":
        return AuthenticationErrorType.weakPassword;
      default:
        return AuthenticationErrorType.unknownError;
    }
  }

  @override
  Future<bool> deleteUser({required String password}) async {
    final email = getCurrentUser()?.email;

    if (email == null) return false;

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await firebase.FirebaseAuth.instance.currentUser
        ?.reauthenticateWithCredential(credential);
    await firebase.FirebaseAuth.instance.currentUser?.delete();
    return true;
  }
}
