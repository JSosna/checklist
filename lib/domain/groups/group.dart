import 'package:checklist/utlis/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final String? name;
  @JsonKey(name: "members_ids")
  final List<String> membersIds;
  @JsonKey(name: "checklists_ids")
  final List<String> checklistsIds;
  @JsonKey(name: "join_code")
  final String? joinCode;
  @JsonKey(name: "join_code_valid_until")
  @TimestampConverter()
  final DateTime? joinCodeValidUntil;
  @JsonKey(name: "admin_id")
  final String? adminId;

  const Group({
    this.id,
    this.name,
    this.membersIds = const [],
    this.checklistsIds = const [],
    this.joinCode,
    this.joinCodeValidUntil,
    this.adminId,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    String? id,
    String? name,
    List<String>? membersIds,
    List<String>? checklistsIds,
    String? joinCode,
    DateTime? joinCodeValidUntil,
    String? adminId,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        membersIds: membersIds ?? this.membersIds,
        checklistsIds: checklistsIds ?? this.checklistsIds,
        joinCode: joinCode ?? this.joinCode,
        joinCodeValidUntil: joinCodeValidUntil ?? this.joinCodeValidUntil,
        adminId: adminId ?? this.adminId,
      );
}
