
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:checklist/domain/groups/use_case/generate_share_code_use_case.dart';

class RefreshShareCodeUseCase {
  final GroupsRepository _groupsRepository;
  final GenerateShareCodeUseCase _generateShareCodeUseCase;

  const RefreshShareCodeUseCase(
    this._groupsRepository,
    this._generateShareCodeUseCase,
  );

  Future<String> refreshCode({required String groupId}) async {
    final code = await _generateShareCodeUseCase.generateCode();

    await _groupsRepository.updateShareCode(
      groupId: groupId,
      shareCode: code,
      shareCodeValidUntil: DateTime.now().add(const Duration(days: 7)),
    );

    return code;
  }
}
