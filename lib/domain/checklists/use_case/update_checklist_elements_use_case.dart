import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:fimber/fimber.dart';

class UpdateChecklistElementsUseCase {
  final ChecklistsRepository _checklistsRepository;

  const UpdateChecklistElementsUseCase(
    this._checklistsRepository,
  );

  Future<bool> updateElements(
    String checklistId,
    List<ChecklistElement> updatedElements,
  ) async {
    try {
      final indexedElements = _updateIndices(updatedElements);

      await _checklistsRepository.updateElements(
        checklistId: checklistId,
        updatedElements: indexedElements,
      );

      return true;
    } catch (e, stack) {
      Fimber.e("Update checklist elements error", ex: e, stacktrace: stack);
    }

    return false;
  }

  List<ChecklistElement> _updateIndices(
    List<ChecklistElement> updatedElements,
  ) {
    for (var i = 0; i < updatedElements.length; i++) {
      updatedElements[i] = updatedElements[i].copyWith(index: i);
    }

    return updatedElements;
  }
}
