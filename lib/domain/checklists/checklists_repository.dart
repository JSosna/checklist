import 'package:checklist/domain/checklists/checklist.dart';

abstract class ChecklistsRepository {
  Future<Checklist> getChecklist({required String checklistId});

  Future<void> deleteChecklist({required String checklistId});

  Future<Checklist> createChecklist({
    required String name,
    required String groupId,
  });

  Future<void> changeChecklistName({
    required String checklistId,
    required String newName,
  });
}
