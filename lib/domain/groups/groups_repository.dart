import 'package:checklist/domain/groups/group.dart';

abstract class GroupsRepository {
  Future<Group?> getGroup({required String groupId});

  Future<Group?> getGroupWithJoinCode({required String joinCode});

  Future<Group?> createGroup({
    required Group group,
  });

  Future<void> addUserToGroup({
    required String groupId,
    required String userId,
  });

  Future<void> removeUserFromGroup({
    required String groupId,
    required String userId,
  });

  Future<void> changeName({
    required String groupId,
    required String name,
  });
}
