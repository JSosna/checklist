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
  Future<Group?> getGroupWithJoinCode({required String joinCode}) async {
    final query = await groups.where("join_code", isEqualTo: joinCode).get();

    if (query.docs.isNotEmpty) {
      final data = query.docs.first.data();
      if (data is Map<String, dynamic>) {
        return Group.fromJson(data);
      }
    }

    return null;
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

    groups.doc(groupId).set(group?.copyWith(membersIds: membersIds).toJson());
  }

  @override
  Future<void> removeUserFromGroup({
    required String groupId,
    required String userId,
  }) async {
    final group = await getGroup(groupId: groupId);

    final membersIds = group?.membersIds ?? [];
    membersIds.remove(userId);

    groups.doc(groupId).set(group?.copyWith(membersIds: membersIds).toJson());
  }
}
