import 'package:bloc/bloc.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/checklists/checklists_repository.dart';
import 'package:checklist/domain/checklists/use_case/is_user_checklist_admin.dart';
import 'package:equatable/equatable.dart';

part 'checklist_details_state.dart';

class ChecklistDetailsCubit extends Cubit<ChecklistDetailsState> {
  final ChecklistsRepository _checklistsRepository;
  final IsUserChecklistAdminUseCase _isUserChecklistAdminUseCase;

  ChecklistDetailsCubit(
    this._checklistsRepository,
    this._isUserChecklistAdminUseCase,
  ) : super(ChecklistDetailsLoading());

  Future<void> loadDetails(String checklistId) async {
    emit(ChecklistDetailsLoading());

    final checklist =
        await _checklistsRepository.getChecklist(checklistId: checklistId);

    if (checklist != null) {
      final groupId = checklist.assignedGroupId;

      if (groupId != null) {
        final isUserAdmin = await _isUserChecklistAdminUseCase
            .isUserChecklistAdmin(groupId, checklist);

        emit(
          ChecklistDetailsLoaded(
            checklist: checklist,
            isUserAdmin: isUserAdmin,
          ),
        );
      } else {
        emit(ChecklistDetailsLoaded(checklist: checklist, isUserAdmin: false));
      }
    } else {
      emit(ChecklistDetailsError());
    }
  }

  Future<void> changeName(String checklistId, String newName) async {
    await _checklistsRepository.changeName(
      checklistId: checklistId,
      newName: newName,
    );
  }
}
