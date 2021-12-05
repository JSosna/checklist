import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailed_group.g.dart';

@JsonSerializable()
class DetailedGroup {
  final Group group;
  final List<User> members;

  const DetailedGroup({
    required this.group,
    required this.members,
  });

  factory DetailedGroup.fromJson(Map<String, dynamic> json) =>
      _$DetailedGroupFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedGroupToJson(this);

  DetailedGroup copyWith({
    Group? group,
    List<User>? members,
  }) =>
      DetailedGroup(
        group: group ?? this.group,
        members: members ?? this.members,
      );
}
