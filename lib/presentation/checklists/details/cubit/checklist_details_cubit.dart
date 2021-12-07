import 'package:bloc/bloc.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:equatable/equatable.dart';

part 'checklist_details_state.dart';

class ChecklistDetailsCubit extends Cubit<ChecklistDetailsState> {
  final ChecklistsRepository _checklistsRepository;

  ChecklistDetailsCubit(this._checklistsRepository)
      : super(ChecklistDetailsLoading());

  Future<void> loadDetails(String checklistId) async {
    emit(ChecklistDetailsLoading());

    final checklist =
        await _checklistsRepository.getChecklist(checklistId: checklistId);

    if (checklist != null) {
      emit(ChecklistDetailsLoaded(checklist: checklist));
    } else {
      emit(ChecklistDetailsError());
    }
  }

  Future<void> changeName(String checklistId, String newName) async {

  }
}
