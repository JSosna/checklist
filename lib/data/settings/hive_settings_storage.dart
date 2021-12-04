import 'package:checklist/data/settings/checklist_settings_entity.dart';
import 'package:checklist/domain/settings/checklist_settings.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:hive/hive.dart';

abstract class HiveSettingsStorage implements SettingsStorage {
  static const String CHECKLIST_SETTINGS = 'CHECKLIST_SETTINGS';

  final Box _settingsBox;

  HiveSettingsStorage(this._settingsBox);

  @override
  ChecklistSettings getAppSettings() {
    final response = _settingsBox.get(CHECKLIST_SETTINGS);

    ChecklistSettingsEntity? settings;

    if (response is ChecklistSettingsEntity) {
      settings = response;
    }

    return ChecklistSettings(
        isBiometricsActive: settings?.isBiometricsActive ?? false);
  }

  @override
  void saveAppSettings(ChecklistSettings fineanceSettings) async {
    final settings = ChecklistSettingsEntity(
        isBiometricsActive: fineanceSettings.isBiometricsActive);

    await _settingsBox.clear();
    await _settingsBox.put(CHECKLIST_SETTINGS, settings);
  }

  @override
  void saveBiometricsOption(bool enableBiometrics) async {
    final settings = getAppSettings();
    saveAppSettings(settings.copyWith(isBiometricsActive: enableBiometrics));
  }

  @override
  bool isBiometricsActive() {
    return getAppSettings().isBiometricsActive;
  }
}
