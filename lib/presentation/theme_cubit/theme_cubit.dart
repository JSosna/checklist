import 'package:bloc/bloc.dart';
import 'package:checklist/domain/theme/theme_mode.dart';
import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeStorage _themeStorage;

  ThemeCubit(ThemeMode initialTheme, this._themeStorage)
      : super(ThemeLoaded(theme: initialTheme));

  void changeThemeMode({required ThemeMode theme}) {
    emit(ThemeLoaded(theme: theme));
    _themeStorage.saveThemeMode(theme);
  }
}
