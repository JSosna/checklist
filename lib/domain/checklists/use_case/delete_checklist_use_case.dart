import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class DeleteChecklistUseCase {
  final ChecklistsRepository _checklistsRepository;
  final GroupsRepository _groupsRepository;

  const DeleteChecklistUseCase(
    this._checklistsRepository,
    this._groupsRepository,
  );

  Future<bool> deleteChecklist(String checklistId, String groupId) async {
    try {
      await _groupsRepository.removeChecklistFromGroup(
        checklistId: checklistId,
        groupId: groupId,
      );

      await _checklistsRepository.deleteChecklist(checklistId: checklistId);

      return true;
    } catch (e, stack) {
      Fimber.e("Creating checklist error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
