import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/use_case/get_join_code_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'share_group_state.dart';

class ShareGroupCubit extends Cubit<ShareGroupState> {
  final GetJoinCodeUseCase _getJoinCodeUseCase;

  ShareGroupCubit(this._getJoinCodeUseCase) : super(ShareGroupLoading());

  Future<void> loadShareCode(String groupId) async {
    emit(ShareGroupLoading());

    try {
      final shareCode = await _getJoinCodeUseCase.getJoinCode(groupId: groupId);

      if (shareCode != null) {
        emit(ShareGroupLoaded(shareCode));
      } else {
        emit(ShareGroupError());
      }
    } catch (e, stack) {
      Fimber.e("Getting join code error", ex: e, stacktrace: stack);
      emit(ShareGroupError());
    }
  }
}
