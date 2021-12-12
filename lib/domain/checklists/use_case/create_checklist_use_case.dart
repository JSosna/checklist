import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class CreateChecklistUseCase {
  final GroupsRepository _groupsRepository;
  final ChecklistsRepository _checklistsRepository;
  final AuthenticationRepository _authenticationRepository;

  const CreateChecklistUseCase(
    this._groupsRepository,
    this._checklistsRepository,
    this._authenticationRepository,
  );

  Future<Checklist?> createChecklist(
    String groupId,
    String name, {
    bool checkable = false,
  }) async {
    try {
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      if (userId != null) {
        final checklist = Checklist(
          name: name,
          assignedGroupId: groupId,
          founderId: userId,
          checkable: checkable,
        );

        final checklistWithId =
            await _checklistsRepository.createChecklist(checklist: checklist);

        if (checklistWithId != null) {
          final checklistId = checklistWithId.id;

          if (checklistId != null) {
            await _groupsRepository.addChecklistToGroup(
              groupId: groupId,
              checklistId: checklistId,
            );

            return checklistWithId;
          }
        }
      }
    } catch (e, stack) {
      Fimber.e("Creating checklist error", ex: e, stacktrace: stack);
    }

    return null;
  }
}
