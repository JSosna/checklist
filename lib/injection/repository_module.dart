import 'package:checklist/data/theme/hive_theme_storage.dart';
import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:checklist/injection/hive_initializer.dart';
import 'package:get_it/get_it.dart';

void registerRepositoryModule(GetIt injector) {
  injector.registerFactory<ThemeStorage>(() => HiveThemeStorage(injector.get(instanceName: THEME_BOX)));
}
