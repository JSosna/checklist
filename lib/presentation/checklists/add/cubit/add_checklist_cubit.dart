import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_checklist_state.dart';

class AddChecklistCubit extends Cubit<AddChecklistState> {
  AddChecklistCubit() : super(AddChecklistInitial());

  Future<void> createNewChecklist(String groupId, String name) async {
    // final group = await _createChecklistUseCase.createChecklist(name);

    // if (group != null) {
    //   emit(CreatedNewChecklist());
    // } else {
    //   emit(ErrorWhileCreatingChecklist());
    // }
  }
}
