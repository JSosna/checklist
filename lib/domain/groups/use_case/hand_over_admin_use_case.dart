import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class HandOverAdminUseCase {
  final GroupsRepository _groupsRepository;

  const HandOverAdminUseCase(
    this._groupsRepository,
  );

  Future<bool> handOverAdmin({
    required String groupId,
    required String memberId,
  }) async {
    try {
      await _groupsRepository.changeAdmin(
        groupId: groupId,
        memberId: memberId,
      );

      return true;
    } catch (e, stack) {
      Fimber.e("Hand over group admin error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
