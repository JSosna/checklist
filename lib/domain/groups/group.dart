import 'package:checklist/domain/authentication/user.dart';

class Group {
  final int? id;
  final String? name;
  final List<User> members;

  const Group({
    required this.id,
    required this.name,
    required this.members,
  });
}
