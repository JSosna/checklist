import 'package:checklist/domain/authentication/user.dart';

abstract class UsersRepository {
  Future<void> addUser({required User user});

  Future<User?> getUser({required String uid});

  Future<void> deleteUser({required String uid});

  Future<void> changeUsername({
    required User user,
    required String username,
  });
}
