import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/users/users_repository.dart';
import 'package:fimber/fimber.dart';

class LoadChecklistsUseCase {
  final ChecklistsRepository _checklistsRepository;
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  final GroupsRepository _groupsRepository;

  const LoadChecklistsUseCase(
    this._checklistsRepository,
    this._authenticationRepository,
    this._usersRepository,
    this._groupsRepository,
  );

  Future<List<Checklist>?> loadChecklists() async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId != null) {
        final groupsIds =
            (await _usersRepository.getUser(userId: userId))?.groupsIds;

        if (groupsIds != null) {
          final checklistsIds = <String>[];
          final checklists = <Checklist>[];

          for (var i = 0; i < groupsIds.length; i++) {
            final group =
                await _groupsRepository.getGroup(groupId: groupsIds[i]);

            if (group != null) {
              checklistsIds.addAll(group.checklistsIds);
            }
          }

          for (var i = 0; i < checklistsIds.length; i++) {
            final checklist = await _checklistsRepository.getChecklist(
              checklistId: checklistsIds[i],
            );

            if (checklist != null) {
              checklists.add(checklist);
            }
          }

          return checklists;
        }
      }
    } catch (e, stack) {
      Fimber.e("Loading checklists error", ex: e, stacktrace: stack);
    }
  }
}
