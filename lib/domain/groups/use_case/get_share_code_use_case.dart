import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/groups/use_case/refresh_share_code_use_case.dart';

class GetShareCodeUseCase {
  final GroupsRepository _groupsRepository;
  final RefreshShareCodeUseCase _refreshShareCodeUseCase;

  const GetShareCodeUseCase(
    this._groupsRepository,
    this._refreshShareCodeUseCase,
  );

  Future<String?> getShareCode({required String groupId}) async {
    final group = await _groupsRepository.getGroup(groupId: groupId);

    if (group != null) {
      final now = DateTime.now();

      if (group.shareCodeValidUntil?.isAfter(now) == true &&
          group.shareCode != null) {
        return group.shareCode;
      } else {
        return _refreshShareCodeUseCase.refreshCode(groupId: groupId);
      }
    }

    return null;
  }
}
