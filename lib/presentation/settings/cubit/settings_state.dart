part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitializing extends SettingsState {}

class SettingsUpdating extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final ChecklistSettings settings;

  const SettingsLoaded({required this.settings});
}
