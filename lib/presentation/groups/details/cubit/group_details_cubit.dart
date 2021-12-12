import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/groups/detailed_group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/groups/use_case/delete_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/hand_over_admin_use_case.dart';
import 'package:checklist/domain/groups/use_case/leave_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/load_detailed_group_use_case.dart';
import 'package:checklist/domain/groups/use_case/remove_group_member_use_case.dart';
import 'package:equatable/equatable.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GroupsRepository _groupsRepository;
  final AuthenticationRepository _authenticationRepository;
  final LoadDetailedGroupUseCase _loadDetailsUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final DeleteGroupUseCase _deleteGroupUseCase;
  final RemoveGroupMemberUseCase _removeGroupMemberUseCase;
  final HandOverAdminUseCase _handOverAdminUseCase;

  GroupDetailsCubit(
    this._groupsRepository,
    this._authenticationRepository,
    this._loadDetailsUseCase,
    this._leaveGroupUseCase,
    this._deleteGroupUseCase,
    this._removeGroupMemberUseCase,
    this._handOverAdminUseCase,
  ) : super(GroupDetailsLoading());

  Future<void> loadDetails(String groupId) async {
    emit(GroupDetailsLoading());
    final detailedGroup =
        await _loadDetailsUseCase.getDetailedGroup(groupId: groupId);
    final currentUserId = _authenticationRepository.getCurrentUser()?.uid;

    if (detailedGroup != null) {
      emit(
        GroupDetailsLoaded(
          detailedGroup: detailedGroup,
          currentUserId: currentUserId ?? "",
        ),
      );
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

  Future<void> removeMember(String groupId, String memberId) async {
    await _removeGroupMemberUseCase.removeMember(
      groupId: groupId,
      memberId: memberId,
    );
    await loadDetails(groupId);
  }

  Future<void> handOverAdmin(String groupId, String memberId) async {
    await _handOverAdminUseCase.handOverAdmin(
      groupId: groupId,
      memberId: memberId,
    );
    await loadDetails(groupId);
  }
}
