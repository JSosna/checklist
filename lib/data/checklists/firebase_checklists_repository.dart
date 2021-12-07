import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChecklistsRepository implements ChecklistsRepository {
  CollectionReference get checklists =>
      FirebaseFirestore.instance.collection('checklists');

  @override
  Future<Checklist?> getChecklist({required String checklistId}) async {
    final response = await checklists.doc(checklistId).get();
    final data = response.data();

    if (response.exists && data is Map<String, dynamic>) {
      return Checklist.fromJson(data);
    }

    return null;
  }

  @override
  Future<void> deleteChecklist({required String checklistId}) async {
    await checklists.doc(checklistId).delete();
  }

  @override
  Future<Checklist?> createChecklist({required Checklist checklist}) async {
    final checklistRef = checklists.doc();
    await checklistRef.set(checklist.copyWith(id: checklistRef.id).toJson());

    return getChecklist(checklistId: checklistRef.id);
  }

  @override
  Future<void> changeChecklistName({
    required String checklistId,
    required String newName,
  }) async {
    final checklist = await getChecklist(checklistId: checklistId);

    await checklists
        .doc(checklistId)
        .set(checklist?.copyWith(name: newName).toJson());
  }

  @override
  Future<void> changeName({
    required String checklistId,
    required String newName,
  }) async {
    final checklist = await getChecklist(checklistId: checklistId);

    await checklists
        .doc(checklistId)
        .set(checklist?.copyWith(name: newName).toJson());
  }
}
