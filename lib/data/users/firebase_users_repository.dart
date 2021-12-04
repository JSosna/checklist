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
  Future<void> deleteUser(String uid) async {
    await users.doc(uid).delete();
  }

  @override
  Future<User?> getUser(String uid) async {
    final response = await users.doc(uid).get();
    final data = response.data();

    if (response.exists && data is Map<String, dynamic>) {
      return User.fromJson(data);
    }

    return null;
  }

  @override
  Future<void> changeUsername(User user, String username) async {
    await users.doc(user.uid).set(user.copyWith(name: username).toJson());
  }
}
