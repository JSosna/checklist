import 'package:hive/hive.dart';

part 'checklist_settings_entity.g.dart';

@HiveType(typeId: 1)
class ChecklistSettingsEntity {
  @HiveField(0)
  final bool isBiometricsActive;

  ChecklistSettingsEntity({
    required this.isBiometricsActive,
  });

  ChecklistSettingsEntity copyWith({bool? isBiometricsActive}) =>
      ChecklistSettingsEntity(
          isBiometricsActive: isBiometricsActive ?? this.isBiometricsActive);
}
