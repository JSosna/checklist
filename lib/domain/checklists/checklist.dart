import 'package:json_annotation/json_annotation.dart';

part 'checklist.g.dart';

@JsonSerializable()
class Checklist {
  final String? id;
  final String? assignedGroupId;
  final String? name;
  final List<String>? membersIds;

  Checklist({
    required this.id,
    required this.assignedGroupId,
    required this.name,
    required this.membersIds,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);

  Checklist copyWith({
    String? id,
    String? assignedGroupId,
    String? name,
    List<String>? membersIds,
  }) =>
      Checklist(
        id: id ?? this.id,
        assignedGroupId: assignedGroupId ?? this.assignedGroupId,
        name: name ?? this.name,
        membersIds: membersIds ?? this.membersIds,
      );
}
