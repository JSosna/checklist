import 'package:checklist/domain/authentication/user.dart';

abstract class UsersRepository {
  Future<void> addUser(User user);

  Future<User> getUser(String uid);

  Future<void> deleteUser(User user);
}
