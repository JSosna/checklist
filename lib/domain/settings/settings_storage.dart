import 'package:checklist/domain/settings/checklist_settings.dart';

abstract class SettingsStorage {
  void saveAppSettings(ChecklistSettings fineanceSettings);

  ChecklistSettings getAppSettings();

  Future<ChecklistSettings> toggleBiometricsOption();

  Future<ChecklistSettings> setBiometricsOption({required bool active});

  bool isBiometricsActive();

}
