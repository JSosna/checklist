import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? uid;
  final String? email;
  final String? name;
  @JsonKey(name: "groups_ids")
  final List<String>? groupsIds;

  User({
    required this.uid,
    required this.email,
    required this.name,
    this.groupsIds = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? uid,
    String? email,
    String? name,
    List<String>? groupsIds,
  }) =>
      User(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        groupsIds: groupsIds ?? this.groupsIds,
      );
}
