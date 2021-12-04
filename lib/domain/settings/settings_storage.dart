import 'package:checklist/domain/settings/checklist_settings.dart';

abstract class SettingsStorage {
  void saveAppSettings(ChecklistSettings fineanceSettings);

  ChecklistSettings getAppSettings();

  Future<ChecklistSettings> toggleBiometricsOption();

  bool isBiometricsActive();
}
