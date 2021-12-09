import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist.g.dart';

@JsonSerializable()
class Checklist {
  final String? id;
  final String? name;
  @JsonKey(name: "assigned_group_id")
  final String? assignedGroupId;
  @JsonKey(name: "founder_id")
  final String? founderId;
  final List<ChecklistElement>? elements;
  final bool checkable;

  Checklist({
    this.id,
    this.name,
    this.assignedGroupId,
    this.founderId,
    this.elements,
    this.checkable = false,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);

  Checklist copyWith({
    String? id,
    String? name,
    String? assignedGroupId,
    String? founderId,
    List<ChecklistElement>? elements,
    bool? checkable,
  }) =>
      Checklist(
        id: id ?? this.id,
        name: name ?? this.name,
        assignedGroupId: assignedGroupId ?? this.assignedGroupId,
        founderId: founderId ?? this.founderId,
        elements: elements ?? this.elements,
        checkable: checkable ?? this.checkable,
      );
}
