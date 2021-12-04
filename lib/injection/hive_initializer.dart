import 'package:checklist/data/settings/checklist_settings_entity.dart';
import 'package:checklist/data/theme/theme_mode.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String THEME_BOX = "THEME_BOX";
const String SETTINGS_BOX = "SETTINGS_BOX";

Future<void> setupHive(GetIt injector) async {
  await Hive.initFlutter();

  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(ChecklistSettingsEntityAdapter());

  await Hive.openBox(THEME_BOX);
  await Hive.openBox(SETTINGS_BOX);

  injector.registerLazySingleton<Box>(() => Hive.box(THEME_BOX),
      instanceName: THEME_BOX);
  injector.registerLazySingleton<Box>(() => Hive.box(SETTINGS_BOX),
      instanceName: SETTINGS_BOX);

}
