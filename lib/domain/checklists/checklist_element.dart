import 'package:json_annotation/json_annotation.dart';

part 'checklist_element.g.dart';

@JsonSerializable()
class ChecklistElement {
  final int? index;
  final String? name;
  final String? description;
  final bool checked;

  ChecklistElement({
    this.index,
    this.name,
    this.description,
    this.checked = false,
  });

  factory ChecklistElement.fromJson(Map<String, dynamic> json) =>
      _$ChecklistElementFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistElementToJson(this);

  ChecklistElement copyWith({
    int? index,
    String? name,
    String? description,
    bool? checked,
  }) =>
      ChecklistElement(
        index: index ?? this.index,
        name: name ?? this.name,
        description: description ?? this.description,
        checked: checked ?? this.checked,
      );
}
