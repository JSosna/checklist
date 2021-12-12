import 'package:bloc/bloc.dart';
import 'package:checklist/domain/groups/use_case/get_share_code_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'share_group_state.dart';

class ShareGroupCubit extends Cubit<ShareGroupState> {
  final GetShareCodeUseCase _getShareCodeUseCase;

  ShareGroupCubit(this._getShareCodeUseCase) : super(ShareGroupLoading());

  Future<void> loadShareCode(String groupId) async {
    emit(ShareGroupLoading());

    try {
      final shareCode = await _getShareCodeUseCase.getShareCode(groupId: groupId);

      if (shareCode != null) {
        emit(ShareGroupLoaded(shareCode));
      } else {
        emit(ShareGroupError());
      }
    } catch (e, stack) {
      Fimber.e("Getting share code error", ex: e, stacktrace: stack);
      emit(ShareGroupError());
    }
  }
}
