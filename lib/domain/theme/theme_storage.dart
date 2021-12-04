import 'package:checklist/data/theme/theme_mode.dart';

abstract class ThemeStorage {
  Future<ThemeMode> loadThemeMode();

  Future<void> saveThemeMode(ThemeMode theme);
}
