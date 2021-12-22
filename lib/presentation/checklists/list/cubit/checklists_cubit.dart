import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group_with_checklists.dart';
import 'package:checklist/domain/groups/use_case/load_groups_with_checklists_use_case.dart';
import 'package:checklist/presentation/checklists/list/checklists_loader_cubit/cubit/checklists_loader_cubit.dart';
import 'package:equatable/equatable.dart';

part 'checklists_state.dart';

class ChecklistsCubit extends Cubit<ChecklistsState> {
  final ChecklistsLoaderCubit _checklistsLoaderCubit;
  final LoadGroupsWithChecklistsUseCase _loadGroupsWithChecklistsUseCase;

  late StreamSubscription _reloadSubscription;

  ChecklistsCubit(
    this._checklistsLoaderCubit,
    this._loadGroupsWithChecklistsUseCase,
  ) : super(ChecklistsLoading()) {
    _reloadSubscription = _checklistsLoaderCubit.stream.listen((event) {
      if (event is ChecklistsLoaderLoaded) {
        if (event.groupsWithChecklists.isEmpty) {
          emit(ChecklistsEmpty());
        } else {
          emit(ChecklistsLoaded(event.groupsWithChecklists));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _reloadSubscription.cancel();
    return super.close();
  }

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
