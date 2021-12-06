import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailed_group.g.dart';

@JsonSerializable()
class DetailedGroup {
  final Group group;
  final List<User> members;
  final List<Checklist> checklists;
  final bool isCurrentUserAdmin;

  const DetailedGroup({
    required this.group,
    required this.members,
    required this.checklists,
    required this.isCurrentUserAdmin,
  });

  factory DetailedGroup.fromJson(Map<String, dynamic> json) =>
      _$DetailedGroupFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedGroupToJson(this);

  DetailedGroup copyWith({
    Group? group,
    List<User>? members,
    List<Checklist>? checklists,
    bool? isCurrentUserAdmin,
  }) =>
      DetailedGroup(
        group: group ?? this.group,
        members: members ?? this.members,
        checklists: checklists ?? this.checklists,
        isCurrentUserAdmin: isCurrentUserAdmin ?? this.isCurrentUserAdmin,
      );
}
