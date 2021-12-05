import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/groups/use_case/delete_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/leave_group_use_case.dart';
import 'package:equatable/equatable.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GroupsRepository _groupsRepository;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final DeleteGroupUseCase _deleteGroupUseCase;

  GroupDetailsCubit(
    this._groupsRepository,
    this._leaveGroupUseCase,
    this._deleteGroupUseCase,
  ) : super(GroupDetailsLoading());

  Future<void> loadDetails(String groupId) async {
    emit(GroupDetailsLoading());
    final group = await _groupsRepository.getGroup(groupId: groupId);

    if (group != null) {
      emit(GroupDetailsLoaded(group: group));
    } else {
      emit(GroupDetailsError());
    }
  }

  Future<void> changeName(String groupId, String name) async {
    await _groupsRepository.changeName(groupId: groupId, name: name);
  }

  Future<void> leaveGroup(String groupId) async {
    emit(GroupDetailsLoading());
    final successful = await _leaveGroupUseCase.leaveGroup(groupId: groupId);

    if (successful) {
      emit(LeftGroup());
    } else {
      emit(GroupDetailsError());
    }
  }

  Future<void> deleteGroup(String groupId) async {
    emit(GroupDetailsLoading());

    final successful = await _deleteGroupUseCase.deleteGroup(groupId: groupId);

    if (successful) {
      emit(LeftGroup());
    } else {
      emit(GroupDetailsError());
    }
  }
}
