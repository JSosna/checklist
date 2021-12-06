import 'package:json_annotation/json_annotation.dart';

part 'checklist.g.dart';

@JsonSerializable()
class Checklist {
  final String? id;
  @JsonKey(name: "assigned_group_id")
  final String? assignedGroupId;
  final String? name;

  Checklist({
    required this.id,
    required this.assignedGroupId,
    required this.name,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);

  Checklist copyWith({
    String? id,
    String? assignedGroupId,
    String? name,
  }) =>
      Checklist(
        id: id ?? this.id,
        assignedGroupId: assignedGroupId ?? this.assignedGroupId,
        name: name ?? this.name,
      );
}
