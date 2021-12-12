import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_with_checklists.g.dart';

@JsonSerializable()
class GroupWithChecklists {
  final Group group;
  final List<Checklist> checklists;

  const GroupWithChecklists({
    required this.group,
    required this.checklists,
  });

  factory GroupWithChecklists.fromJson(Map<String, dynamic> json) =>
      _$GroupWithChecklistsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupWithChecklistsToJson(this);

  GroupWithChecklists copyWith({
    Group? group,
    List<Checklist>? checklists,
  }) =>
      GroupWithChecklists(
        group: group ?? this.group,
        checklists: checklists ?? this.checklists,
      );
}
