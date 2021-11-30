import 'package:checklist/domain/theme/theme_mode.dart';

abstract class ThemeStorage {
  Future<ThemeMode> loadThemeMode();

  Future<void> saveThemeMode(ThemeMode theme);
}
