import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/groups/groups_repository.dart';
import 'package:fimber/fimber.dart';

class IsUserChecklistAdminUseCase {
  final AuthenticationRepository _authenticationRepository;
  final GroupsRepository _groupsRepository;

  const IsUserChecklistAdminUseCase(
    this._authenticationRepository,
    this._groupsRepository,
  );

  Future<bool> isUserChecklistAdmin(String groupId, Checklist checklist) async {
    try {
      final adminId =
          (await _groupsRepository.getGroup(groupId: groupId))?.adminId;
      final userId = _authenticationRepository.getCurrentUser()?.uid;

      return adminId == userId || checklist.founderId == userId;
    } catch (e, stack) {
      Fimber.e("Is user group admin error", ex: e, stacktrace: stack);
    }

    return false;
  }
}
