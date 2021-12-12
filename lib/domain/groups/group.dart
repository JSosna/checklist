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
  @JsonKey(name: "share_code")
  final String? shareCode;
  @JsonKey(name: "share_code_valid_until")
  @TimestampConverter()
  final DateTime? shareCodeValidUntil;
  @JsonKey(name: "admin_id")
  final String? adminId;

  const Group({
    this.id,
    this.name,
    this.membersIds = const [],
    this.checklistsIds = const [],
    this.shareCode,
    this.shareCodeValidUntil,
    this.adminId,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    String? id,
    String? name,
    List<String>? membersIds,
    List<String>? checklistsIds,
    String? shareCode,
    DateTime? shareCodeValidUntil,
    String? adminId,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        membersIds: membersIds ?? this.membersIds,
        checklistsIds: checklistsIds ?? this.checklistsIds,
        shareCode: shareCode ?? this.shareCode,
        shareCodeValidUntil: shareCodeValidUntil ?? this.shareCodeValidUntil,
        adminId: adminId ?? this.adminId,
      );
}
