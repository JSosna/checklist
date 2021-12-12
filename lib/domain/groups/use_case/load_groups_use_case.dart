import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LoadGroupsUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  LoadGroupsUseCase(
    this._authenticationRepository,
    this._usersRepository,
    this._groupsRepository,
  );

  Future<List<Group>?> loadGroups({String? filter}) async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId != null) {
        final user = await _usersRepository.getUser(userId: userId);

        if (user != null) {
          final groupsIds = user.groupsIds;
          final groups = <Group>[];

          for (final String groupId in groupsIds ?? []) {
            final group = await _groupsRepository.getGroup(groupId: groupId);

            if (group != null) {
              if (filter == null) {
                groups.add(group);
              } else {
                if (_containsString(group.name, filter)) {
                  groups.add(group);
                }
              }
            }
          }

          return groups;
        }
      }
    } catch (e, stack) {
      Fimber.e("Loading groups error", ex: e, stacktrace: stack);
    }
    return null;
  }

  bool _containsString(String? name, String filter) {
    if (name != null) {
      if (name.toUpperCase().contains(filter.toUpperCase())) {
        return true;
      }
    }

    return false;
  }
}
