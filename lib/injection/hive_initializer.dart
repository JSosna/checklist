import 'package:checklist/domain/theme/theme_mode.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String THEME_BOX = 'THEME_BOX';

Future<void> setupHive(GetIt injector) async {
  await Hive.initFlutter();

  Hive.registerAdapter(ThemeModeAdapter());

  await Hive.openBox(THEME_BOX);

  injector.registerLazySingleton<Box>(() => Hive.box(THEME_BOX),
      instanceName: THEME_BOX);
}
