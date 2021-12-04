import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final String? name;
  @JsonKey(name: "members_ids")
  final List<String>? membersIds;

  const Group({
    this.id,
    this.name,
    this.membersIds,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    String? id,
    String? name,
    List<String>? membersIds,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        membersIds: membersIds ?? this.membersIds,
      );
}
