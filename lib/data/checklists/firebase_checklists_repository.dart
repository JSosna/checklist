import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';

class FirebaseChecklistsRepository implements ChecklistsRepository {
  @override
  Future<void> changeChecklistName({required String checklistId, required String newName}) {
    // TODO: implement changeChecklistName
    throw UnimplementedError();
  }

  @override
  Future<Checklist> createChecklist({required String name, required String groupId}) {
    // TODO: implement createChecklist
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChecklist({required String checklistId}) {
    // TODO: implement deleteChecklist
    throw UnimplementedError();
  }

  @override
  Future<Checklist> getChecklist({required String checklistId}) {
    // TODO: implement getChecklist
    throw UnimplementedError();
  }

}
