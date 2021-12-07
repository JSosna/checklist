import 'package:checklist/domain/checklists/checklist.dart';

abstract class ChecklistsRepository {
  Future<Checklist?> getChecklist({required String checklistId});

  Future<void> deleteChecklist({required String checklistId});

  Future<Checklist?> createChecklist({
    required Checklist checklist,
  });

  Future<void> changeChecklistName({
    required String checklistId,
    required String newName,
  });

  Future<void> changeName({
    required String checklistId,
    required String newName,
  });
}
