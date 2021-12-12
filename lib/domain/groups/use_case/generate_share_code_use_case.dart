import 'dart:math';

import 'package:checklist/domain/groups/groups_repository.dart';

class GenerateShareCodeUseCase {
  final GroupsRepository _groupsRepository;

  const GenerateShareCodeUseCase(
    this._groupsRepository,
  );

  Future<String> generateCode() async {
    String code = _generate();

    while (await _groupsRepository.anyGroupContainsShareCode(
      shareCode: code,
    )) {
      code = _generate();
    }

    return code;
  }

  String _generate() {
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
