import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:equatable/equatable.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GroupsRepository _groupsRepository;

  GroupDetailsCubit(this._groupsRepository) : super(GroupDetailsLoading());

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
}
