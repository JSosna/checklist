import 'package:checklist/domain/users/user.dart';

abstract class UsersRepository {
  Future<void> addUser({required User user});

  Future<User?> getUser({required String userId});

  Future<void> deleteUser({required String userId});

  Future<void> changeUsername({
    required User user,
    required String username,
  });

  Future<void> addGroup({
    required String userId,
    required String groupId,
  });

  Future<void> removeGroup({
    required String userId,
    required String groupId,
  });
}
