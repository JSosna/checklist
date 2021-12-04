import 'package:checklist/data/settings/checklist_settings_entity.dart';
import 'package:checklist/data/theme/theme_mode.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String themeBox = "THEME_BOX";
const String settingsBox = "SETTINGS_BOX";

Future<void> setupHive(GetIt injector) async {
  await Hive.initFlutter();

  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(ChecklistSettingsEntityAdapter());

  await Hive.openBox(themeBox);
  await Hive.openBox(settingsBox);

  injector.registerLazySingleton<Box>(
    () => Hive.box(themeBox),
    instanceName: themeBox,
  );
  injector.registerLazySingleton<Box>(
    () => Hive.box(settingsBox),
    instanceName: settingsBox,
  );
}
