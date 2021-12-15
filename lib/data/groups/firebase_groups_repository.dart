import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGroupsRepository implements GroupsRepository {
  CollectionReference get groups =>
      FirebaseFirestore.instance.collection('groups');

  @override
  Future<Group?> getGroup({required String groupId}) async {
    final response = await groups.doc(groupId).get();
    final data = response.data();

    if (response.exists && data is Map<String, dynamic>) {
      return Group.fromJson(data);
    }

    return null;
  }

  @override
  Future<Group?> getGroupWithShareCode({required String shareCode}) async {
    final query = await groups.where("share_code", isEqualTo: shareCode).get();

    if (query.docs.isNotEmpty) {
      final data = query.docs.first.data();
      if (data is Map<String, dynamic>) {
        return Group.fromJson(data);
      }
    }

    return null;
  }

  @override
  Future<void> deleteGroup({required String groupId}) async {
    await groups.doc(groupId).delete();
  }

  @override
  Future<Group?> createGroup({
    required Group group,
  }) async {
    final groupRef = groups.doc();
    await groupRef.set(group.copyWith(id: groupRef.id).toJson());

    return getGroup(groupId: groupRef.id);
  }

  @override
  Future<void> addUserToGroup({
    required String groupId,
    required String userId,
  }) async {
    final group = await getGroup(groupId: groupId);

    final membersIds = group?.membersIds ?? [];
    membersIds.add(userId);

    await groups
        .doc(groupId)
        .set(group?.copyWith(membersIds: membersIds).toJson());
  }

  @override
  Future<void> addChecklistToGroup({
    required String checklistId,
    required String groupId,
  }) async {
    final group = await getGroup(groupId: groupId);

    final checklistsIds = group?.checklistsIds ?? [];
    checklistsIds.add(checklistId);

    await groups
        .doc(groupId)
        .set(group?.copyWith(checklistsIds: checklistsIds).toJson());
  }

  @override
  Future<void> removeChecklistFromGroup({
    required String checklistId,
    required String groupId,
  }) async {
    final group = await getGroup(groupId: groupId);

    final checklistsIds = group?.checklistsIds ?? [];
    checklistsIds.remove(checklistId);

    await groups
        .doc(groupId)
        .set(group?.copyWith(checklistsIds: checklistsIds).toJson());
  }

  @override
  Future<void> removeUserFromGroup({
    required String groupId,
    required String userId,
  }) async {
    final group = await getGroup(groupId: groupId);

    final membersIds = group?.membersIds ?? [];
    membersIds.remove(userId);

    await groups
        .doc(groupId)
        .set(group?.copyWith(membersIds: membersIds).toJson());
  }

  @override
  Future<void> changeName({
    required String groupId,
    required String name,
  }) async {
    await groups.doc(groupId).update({
      "name": name,
    });
  }

  @override
  Future<bool> isCurrentUserAdmin(String userId, String groupId) async {
    final group = await getGroup(groupId: groupId);

    return group?.adminId == userId;
  }

  @override
  Future<void> updateShareCode({
    required String groupId,
    required String shareCode,
    required DateTime shareCodeValidUntil,
  }) async {
    await groups.doc(groupId).update({
      "share_code": shareCode,
      "share_code_valid_until": shareCodeValidUntil,
    });
  }

  @override
  Future<bool> anyGroupContainsShareCode({required String shareCode}) async {
    final query = await groups.where("share_code", isEqualTo: shareCode).get();
    return query.docs.isNotEmpty;
  }

  @override
  Future<void> changeAdmin({
    required String groupId,
    required String memberId,
  }) async {
    await groups.doc(groupId).update({
      "admin_id": memberId,
    });
  }
}
