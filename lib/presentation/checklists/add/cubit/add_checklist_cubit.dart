import 'package:bloc/bloc.dart';
import 'package:checklist/domain/checklists/use_case/create_checklist_use_case.dart';
import 'package:equatable/equatable.dart';

part 'add_checklist_state.dart';

class AddChecklistCubit extends Cubit<AddChecklistState> {
  final CreateChecklistUseCase _createChecklistUseCase;

  AddChecklistCubit(this._createChecklistUseCase)
      : super(AddChecklistInitial());

  Future<void> createNewChecklist(
    String groupId,
    String name, {
    bool checkable = false,
  }) async {
    final checklist = await _createChecklistUseCase
        .createChecklist(groupId, name, checkable: checkable);

    if (checklist != null) {
      emit(CreatedNewChecklist());
    } else {
      emit(ErrorWhileCreatingChecklist());
    }
  }
}
