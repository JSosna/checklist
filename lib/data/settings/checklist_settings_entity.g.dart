// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_settings_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChecklistSettingsEntityAdapter
    extends TypeAdapter<ChecklistSettingsEntity> {
  @override
  final int typeId = 1;

  @override
  ChecklistSettingsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChecklistSettingsEntity(
      isBiometricsActive: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChecklistSettingsEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isBiometricsActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChecklistSettingsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
