import 'package:checklist/domain/authentication/user.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersRepository implements UsersRepository {
  CollectionReference get users =>
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(User user) async {
    await users.doc(user.uid).set(user.toJson());
  }

  @override
  Future<void> deleteUser(User user) async {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String uid) async {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> changeUsername(User user, String username) async {
    await users.doc(user.uid).set(user.copyWith(name: username).toJson());
  }
}
