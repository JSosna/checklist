import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group_with_checklists.dart';
import 'package:checklist/domain/groups/use_case/load_groups_with_checklists_use_case.dart';
import 'package:equatable/equatable.dart';

part 'checklists_state.dart';

class ChecklistsCubit extends Cubit<ChecklistsState> {
  final LoadGroupsWithChecklistsUseCase _loadGroupsWithChecklistsUseCase;

  ChecklistsCubit(this._loadGroupsWithChecklistsUseCase)
      : super(ChecklistsLoading());

  Future<void> loadChecklists() async {
    emit(ChecklistsLoading());

    final groupsWithChecklists =
        await _loadGroupsWithChecklistsUseCase.getGroupsWithChecklists();

    if (groupsWithChecklists != null) {
      emit(ChecklistsLoaded(groupsWithChecklists));
    } else {
      emit(ChecklistLoadingError());
    }
  }
}
