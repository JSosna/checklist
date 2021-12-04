import 'package:checklist/data/theme/theme_mode.dart';
import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:hive/hive.dart';

class HiveThemeStorage extends ThemeStorage {
  static const String THEME_MODE = 'THEME_MODE';

  final Box themeBox;

  HiveThemeStorage(this.themeBox);

  @override
  Future<ThemeMode> loadThemeMode() async {
    final theme = themeBox.get(THEME_MODE);

    if (theme is ThemeMode) {
      return theme;
    }

    return ThemeMode.light;
  }

  @override
  Future<void> saveThemeMode(ThemeMode theme) async {
    await themeBox.put(THEME_MODE, theme);
  }
}
