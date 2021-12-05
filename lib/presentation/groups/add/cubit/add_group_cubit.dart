import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/add_user_to_existing_group_use_case.dart';
import 'package:checklist/domain/groups/create_group_use_case.dart';
import 'package:equatable/equatable.dart';

part 'add_group_state.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  final AddUserToExistingGroupUseCase _addUserToExistingGroupUseCase;
  final CreateGroupUseCase _createGroupUseCase;

  AddGroupCubit(
    this._addUserToExistingGroupUseCase,
    this._createGroupUseCase,
  ) : super(AddGroupInitial());

  Future<void> joinToExistingGroup(String code) async {
    final successful =
        await _addUserToExistingGroupUseCase.addUserToExistingGroup(code);

    if (successful) {
      emit(AddedUserToGroup());
    } else {
      emit(ErrorWhileAddingUserToGroup());
    }
  }

  Future<void> createNewGroup(String name) async {
    final group = await _createGroupUseCase.createGroup(name);

    if (group != null) {
      emit(CreatedNewGroup());
    } else {
      emit(ErrorWhileCreatingGroup());
    }
  }
}
