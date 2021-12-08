import 'package:checklist/domain/groups/group.dart';

abstract class GroupsRepository {
  Future<Group?> getGroup({required String groupId});

  Future<Group?> getGroupWithJoinCode({required String joinCode});

  Future<void> deleteGroup({required String groupId});

  Future<Group?> createGroup({
    required Group group,
  });

  Future<void> addUserToGroup({
    required String groupId,
    required String userId,
  });

  Future<void> addChecklistToGroup({
    required String checklistId,
    required String groupId,
  });

  Future<void> removeChecklistFromGroup({
    required String checklistId,
    required String groupId,
  });

  Future<void> removeUserFromGroup({
    required String groupId,
    required String userId,
  });

  Future<void> changeName({
    required String groupId,
    required String name,
  });

  Future<bool> isCurrentUserAdmin(
    String userId,
    String groupId,
  );
}
