import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGroupsRepository implements GroupsRepository {
  CollectionReference get groups =>
      FirebaseFirestore.instance.collection('groups');

  @override
  Future<Group?> getGroup(String id) async {
    final response = await groups.doc(id).get();
    final data = response.data();

    if (response.exists && data is Map<String, dynamic>) {
      return Group.fromJson(data);
    }

    return null;
  }

  @override
  Future<void> createGroup({
    required Group group,
  }) async {
    final groupRef = groups.doc();
    groupRef.set(group.toJson());
  }

  @override
  Future<void> addUserToGroup({
    required String groupId,
    required String userId,
  }) async {
    final group = await getGroup(groupId);

    final membersIds = group?.membersIds ?? [];
    membersIds.add(userId);

    groups.doc(groupId).set(group?.copyWith(membersIds: membersIds));
  }

  @override
  Future<void> removeUserFromGroup({
    required String groupId,
    required String userId,
  }) async {
    final group = await getGroup(groupId);

    final membersIds = group?.membersIds ?? [];
    membersIds.remove(userId);

    groups.doc(groupId).set(group?.copyWith(membersIds: membersIds));
  }
}
