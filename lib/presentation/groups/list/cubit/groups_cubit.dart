import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:checklist/presentation/groups/list/groups_loader_cubit/groups_loader_cubit.dart';
import 'package:equatable/equatable.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final GroupsLoaderCubit _groupsLoaderCubit;
  final LoadGroupsUseCase _loadGroupsUseCase;

  late StreamSubscription _reloadSubscription;

  GroupsCubit(this._groupsLoaderCubit, this._loadGroupsUseCase)
      : super(GroupsLoading()) {
    _reloadSubscription = _groupsLoaderCubit.stream.listen((event) {
      if (event is GroupsLoaderLoaded) {
        emit(GroupsLoaded(event.groups));
      }
    });
  }

  @override
  Future<void> close() {
    _reloadSubscription.cancel();
    return super.close();
  }

  Future<void> loadGroups() async {
    emit(GroupsLoading());

    final groups = await _loadGroupsUseCase.loadGroups();

    if (groups != null) {
      emit(GroupsLoaded(groups));
    } else {
      emit(GroupsError());
    }
  }
}
