import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/use_case/load_groups_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'groups_loader_state.dart';

class GroupsLoaderCubit extends Cubit<GroupsLoaderState> {
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupsLoaderCubit(this._loadGroupsUseCase) : super(GroupsLoaderIdle());

  Future<void> reloadGroups() async {
    emit(GroupsLoaderLoading());

    try {
      final groups = await _loadGroupsUseCase.loadGroups();
      emit(GroupsLoaderLoaded(groups: groups ?? []));
    } catch (e, stack) {
      Fimber.e("Load groups error", ex: e, stacktrace: stack);
    }
    emit(GroupsLoaderIdle());
  }
}
