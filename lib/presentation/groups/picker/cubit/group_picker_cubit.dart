import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:checklist/presentation/groups/picker/group_picker_loader_cubit/group_picker_loader_cubit.dart';
import 'package:equatable/equatable.dart';

part 'group_picker_state.dart';

class GroupPickerCubit extends Cubit<GroupPickerState> {
  final GroupPickerLoaderCubit _groupPickerLoaderCubit;
  final LoadGroupsUseCase _loadGroupsUseCase;

  late StreamSubscription _reloadSubscription;

  GroupPickerCubit(this._groupPickerLoaderCubit, this._loadGroupsUseCase)
      : super(GroupPickerLoading()) {
    _reloadSubscription = _groupPickerLoaderCubit.stream.listen((event) {
      if (event is GroupPickerLoaderLoaded) {
        emit(GroupPickerLoaded(groups: event.groups));
      }
    });
  }

  @override
  Future<void> close() {
    _reloadSubscription.cancel();
    return super.close();
  }

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
