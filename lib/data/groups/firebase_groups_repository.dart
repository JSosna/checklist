import 'package:checklist/domain/authentication/user.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';

class FirebaseGroupsRepository implements GroupsRepository {
  @override
  Future<List<Group>> getUserGroups({required User user}) async {
    return [];
  }

  @override
  Future<void> createGroup({
    required User founder,
    required String name,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> joinGroup({required String groupId}) {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }

  @override
  Future<void> leaveGroup({required String groupId}) {
    // TODO: implement leaveGroup
    throw UnimplementedError();
  }
}
