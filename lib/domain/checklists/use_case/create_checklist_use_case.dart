import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class CreateChecklistUseCase {
  final GroupsRepository _groupsRepository;
  final ChecklistsRepository _checklistsRepository;

  const CreateChecklistUseCase(
    this._groupsRepository,
    this._checklistsRepository,
  );

  Future<Checklist?> createChecklist(String groupId, String name) async {
    try {
      final checklist = Checklist(
        name: name,
        assignedGroupId: groupId,
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
    } catch (e, stack) {
      Fimber.e("Creating checklist error", ex: e, stacktrace: stack);
    }

    return null;
  }
}
