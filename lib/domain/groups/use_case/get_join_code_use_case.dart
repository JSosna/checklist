import 'package:checklist/domain/groups/groups_repository.dart';

class GetJoinCodeUseCase {
  final GroupsRepository _groupsRepository;

  const GetJoinCodeUseCase(
    this._groupsRepository,
  );

  Future<String?> getJoinCode({required String groupId}) async {
    final group = await _groupsRepository.getGroup(groupId: groupId);

    return group?.joinCode;
  }
}
