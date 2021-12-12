import 'package:checklist/domain/groups/groups_repository.dart';

class GetShareCodeUseCase {
  final GroupsRepository _groupsRepository;

  const GetShareCodeUseCase(
    this._groupsRepository,
  );

  Future<String?> getShareCode({required String groupId}) async {
    final group = await _groupsRepository.getGroup(groupId: groupId);

    return group?.shareCode;
  }
}
