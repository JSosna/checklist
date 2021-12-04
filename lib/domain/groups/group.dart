import 'package:checklist/domain/authentication/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final String? name;
  final List<User>? members;

  const Group({
    this.id,
    this.name,
    this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    String? id,
    String? name,
    List<User>? members,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        members: members ?? this.members,
      );
}
