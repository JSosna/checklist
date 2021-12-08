import 'package:json_annotation/json_annotation.dart';

part 'checklist.g.dart';

@JsonSerializable()
class Checklist {
  final String? id;
  final String? name;
  @JsonKey(name: "assigned_group_id")
  final String? assignedGroupId;
  final String? founderId;

  Checklist({
    this.id,
    this.name,
    this.assignedGroupId,
    this.founderId,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);

  Checklist copyWith({
    String? id,
    String? name,
    String? assignedGroupId,
    String? founderId,
  }) =>
      Checklist(
        id: id ?? this.id,
        name: name ?? this.name,
        assignedGroupId: assignedGroupId ?? this.assignedGroupId,
        founderId: founderId ?? this.founderId,
      );
}
