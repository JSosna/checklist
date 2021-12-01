import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/authentication/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
// import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  @override
  Future<AuthenticationResponse> login(
      {required String email, required String password}) async {
    final user = await firebase.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (user.user != null) {
      return AuthenticationSuccess(
          user: User(
              uid: user.user?.uid,
              email: user.user?.email,
              name: user.user?.displayName));
    }

    return const AuthenticationError(message: "error");
  }

  @override
  Future<AuthenticationResponse> register(
      {required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
