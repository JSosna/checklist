import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'group_picker_loader_state.dart';

class GroupPickerLoaderCubit extends Cubit<GroupPickerLoaderState> {
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupPickerLoaderCubit(this._loadGroupsUseCase)
      : super(GroupPickerLoaderIdle());

  Future<void> reloadGroups(String filter) async {
    emit(GroupPickerLoaderLoading());

    try {
      final result = await _loadGroupsUseCase.loadGroups(filter: filter);
      emit(GroupPickerLoaderLoaded(groups: result ?? []));
    } catch (e, stack) {
      Fimber.e("Load groups error", ex: e, stacktrace: stack);
    }

    emit(GroupPickerLoaderIdle());
  }
}
