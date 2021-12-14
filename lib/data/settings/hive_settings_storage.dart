import 'package:checklist/data/settings/checklist_settings_entity.dart';
import 'package:checklist/domain/settings/checklist_settings.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:hive/hive.dart';

class HiveSettingsStorage implements SettingsStorage {
  static const String checklistSettings = 'CHECKLIST_SETTINGS';

  final Box _settingsBox;

  HiveSettingsStorage(this._settingsBox);

  @override
  ChecklistSettings getAppSettings() {
    final response = _settingsBox.get(checklistSettings);

    ChecklistSettingsEntity? settings;

    if (response is ChecklistSettingsEntity) {
      settings = response;
    }

    return ChecklistSettings(
      isBiometricsActive: settings?.isBiometricsActive ?? false,
    );
  }

  @override
  Future<void> saveAppSettings(ChecklistSettings fineanceSettings) async {
    final settings = ChecklistSettingsEntity(
      isBiometricsActive: fineanceSettings.isBiometricsActive,
    );

    await _settingsBox.clear();
    await _settingsBox.put(checklistSettings, settings);
  }

  @override
  Future<ChecklistSettings> toggleBiometricsOption() async {
    final settings = getAppSettings();

    await saveAppSettings(
      settings.copyWith(isBiometricsActive: !settings.isBiometricsActive),
    );

    return getAppSettings();
  }

    @override
  Future<ChecklistSettings> setBiometricsOption({required bool active}) async {
    final settings = getAppSettings();

    await saveAppSettings(
      settings.copyWith(isBiometricsActive: active),
    );

    return getAppSettings();
  }

  @override
  bool isBiometricsActive() {
    return getAppSettings().isBiometricsActive;
  }
}
