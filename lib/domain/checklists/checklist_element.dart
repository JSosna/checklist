import 'package:json_annotation/json_annotation.dart';

part 'checklist_element.g.dart';

@JsonSerializable()
class ChecklistElement {
  final String? name;
  final String? description;

  ChecklistElement({
    this.name,
    this.description,
  });

  factory ChecklistElement.fromJson(Map<String, dynamic> json) =>
      _$ChecklistElementFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistElementToJson(this);

  ChecklistElement copyWith({
    String? name,
    String? description,
  }) =>
      ChecklistElement(
        name: name ?? this.name,
        description: description ?? this.description,
      );
}
