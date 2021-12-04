import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String? id;
  final String? name;
  @JsonKey(name: "members_ids")
  final List<String>? membersIds;
  @JsonKey(name: "join_code")
  final String? joinCode;
  @JsonKey(name: "join_code_valid_until")
  @TimestampConverter()
  final DateTime? joinCodeValidUntil;

  const Group({
    this.id,
    this.name,
    this.membersIds,
    this.joinCode,
    this.joinCodeValidUntil,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    String? id,
    String? name,
    List<String>? membersIds,
    String? joinCode,
    DateTime? joinCodeValidUntil,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        membersIds: membersIds ?? this.membersIds,
        joinCode: joinCode ?? this.joinCode,
        joinCodeValidUntil: joinCodeValidUntil ?? this.joinCodeValidUntil,
      );
}

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) =>
      date != null ? Timestamp.fromDate(date) : null;
}
