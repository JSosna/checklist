import 'package:checklist/domain/authentication/user.dart';
import 'package:checklist/domain/groups/group.dart';

abstract class GroupsRepository {
  Future<List<Group>> getUserGroups({required User user});

  Future<void> createGroup({
    required User founder,
    required String name,
  });

  Future<void> joinGroup({required String groupId});

  Future<void> leaveGroup({required String groupId});
}
