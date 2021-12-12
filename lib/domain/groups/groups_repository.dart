import 'package:checklist/domain/groups/group.dart';

abstract class GroupsRepository {
  Future<Group?> getGroup({required String groupId});

  Future<Group?> getGroupWithShareCode({required String shareCode});

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

  Future<void> updateShareCode({
    required String groupId,
    required String shareCode,
    required DateTime shareCodeValidUntil,
  });

  Future<bool> anyGroupContainsShareCode({
    required String shareCode,
  });

  Future<void> changeAdmin({required String groupId, required String memberId});
}
