import 'package:checklist/domain/users/user.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersRepository implements UsersRepository {
  CollectionReference get users =>
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser({required User user}) async {
    await users.doc(user.uid).set(user.toJson());
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    await users.doc(userId).delete();
  }

  @override
  Future<User?> getUser({required String userId}) async {
    final response = await users.doc(userId).get();
    final data = response.data();

    if (response.exists && data is Map<String, dynamic>) {
      return User.fromJson(data);
    }

    return null;
  }

  @override
  Future<void> changeUsername({
    required User user,
    required String username,
  }) async {
    await users.doc(user.uid).update({"name": username});
  }

  @override
  Future<void> addGroup({
    required String userId,
    required String groupId,
  }) async {
    final user = await getUser(userId: userId);

    final groupsIds = user?.groupsIds ?? [];
    groupsIds.add(groupId);

    await users.doc(userId).set(user?.copyWith(groupsIds: groupsIds).toJson());
  }

  @override
  Future<void> removeGroup({
    required String userId,
    required String groupId,
  }) async {
    final user = await getUser(userId: userId);

    final groupsIds = user?.groupsIds ?? [];
    groupsIds.remove(groupId);

    await users.doc(userId).set(user?.copyWith(groupsIds: groupsIds).toJson());
  }
}
