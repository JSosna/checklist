import 'package:checklist/domain/settings/checklist_settings.dart';

abstract class SettingsStorage {
  void saveAppSettings(ChecklistSettings fineanceSettings);

  ChecklistSettings getAppSettings();

  void saveBiometricsOption(bool enableBiometrics);

  bool isBiometricsActive();
}