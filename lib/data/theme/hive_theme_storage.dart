import 'package:checklist/data/theme/theme_mode.dart';
import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:hive/hive.dart';

class HiveThemeStorage implements ThemeStorage {
  static const String themeMode = 'THEME_MODE';

  final Box themeBox;

  HiveThemeStorage(this.themeBox);

  @override
  Future<ThemeMode> loadThemeMode() async {
    final theme = themeBox.get(themeMode);

    if (theme is ThemeMode) {
      return theme;
    }

    return ThemeMode.light;
  }

  @override
  Future<void> saveThemeMode(ThemeMode theme) async {
    await themeBox.put(themeMode, theme);
  }
}
