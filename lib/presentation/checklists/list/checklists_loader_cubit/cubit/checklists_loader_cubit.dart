import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group_with_checklists.dart';
import 'package:checklist/domain/groups/use_case/load_groups_with_checklists_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'checklists_loader_state.dart';

class ChecklistsLoaderCubit extends Cubit<ChecklistsLoaderState> {
  final LoadGroupsWithChecklistsUseCase _loadGroupsWithChecklistsUseCase;

  ChecklistsLoaderCubit(this._loadGroupsWithChecklistsUseCase)
      : super(ChecklistsLoaderIdle());

  Future<void> reloadChecklists() async {
    emit(ChecklistsLoaderLoading());

    try {
      final groupsWithChecklists =
          await _loadGroupsWithChecklistsUseCase.getGroupsWithChecklists();
      emit(ChecklistsLoaderLoaded(groupsWithChecklists ?? []));
    } catch (e, stack) {
      Fimber.e("Load groups with checklists error", ex: e, stacktrace: stack);
    }
    emit(ChecklistsLoaderIdle());
  }
}
