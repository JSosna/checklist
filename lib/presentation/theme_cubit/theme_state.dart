part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode theme;

  const ThemeState({required this.theme});

  @override
  List<Object> get props => [theme];
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({required ThemeMode theme}) : super(theme: theme);
}
