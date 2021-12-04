import 'package:checklist/domain/authentication/user.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersRepository implements UsersRepository {
  CollectionReference get users =>
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(User user) async {
    await users.add(user.toJson());
  }

  @override
  Future<void> deleteUser(User user) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String uid) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
