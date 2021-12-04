import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/load_groups_use_case.dart';
import 'package:equatable/equatable.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupsCubit(this._loadGroupsUseCase) : super(GroupsLoading());

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
