import 'package:bloc/bloc.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/use_case/load_checklists_use_case.dart';
import 'package:equatable/equatable.dart';

part 'checklists_state.dart';

class ChecklistsCubit extends Cubit<ChecklistsState> {
  final LoadChecklistsUseCase _loadChecklistsUseCase;

  ChecklistsCubit(this._loadChecklistsUseCase) : super(ChecklistsLoading());

  Future<void> loadChecklists() async {
    emit(ChecklistsLoading());

    final checklists = await _loadChecklistsUseCase.loadChecklists();

    if (checklists != null) {
      emit(ChecklistsLoaded(checklists));
    } else {
      emit(ChecklistLoadingError());
    }
  }
}
