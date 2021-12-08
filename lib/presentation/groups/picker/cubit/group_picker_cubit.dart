import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:equatable/equatable.dart';

part 'group_picker_state.dart';

class GroupPickerCubit extends Cubit<GroupPickerState> {
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupPickerCubit(this._loadGroupsUseCase) : super(GroupPickerLoading());

  Future<void> loadGroups(String filter) async {
    emit(GroupPickerLoading());

    final result = await _loadGroupsUseCase.loadGroups(filter: filter);

    if (result != null) {
      emit(GroupPickerLoaded(groups: result));
    } else {
      emit(GroupPickerError());
    }
  }
}
