import 'dart:math';

import 'package:checklist/domain/groups/groups_repository.dart';

class GetShareCodeUseCase {
  final GroupsRepository _groupsRepository;

  const GetShareCodeUseCase(
    this._groupsRepository,
  );

  Future<String?> getShareCode({required String groupId}) async {
    final group = await _groupsRepository.getGroup(groupId: groupId);

    if (group != null) {
      final now = DateTime.now();

      if (group.shareCodeValidUntil?.isAfter(now) == true &&
          group.shareCode != null) {
        return group.shareCode;
      } else {
        String code = generateCode();

        while (await _groupsRepository.anyGroupContainsShareCode(
          shareCode: code,
        )) {
          code = generateCode();
        }

        await _groupsRepository.updateShareCode(
          groupId: groupId,
          shareCode: code,
          shareCodeValidUntil: now.add(const Duration(days: 7)),
        );

        return code;
      }
    }

    return null;
  }

  String generateCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final random = Random.secure();

    return String.fromCharCodes(
      Iterable.generate(
        6,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }
}
