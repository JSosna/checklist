part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsUpdating extends SettingsState {}

class AccountDeleteFailed extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final ChecklistSettings settings;
  final User? user;

  const SettingsLoaded({required this.settings, required this.user});
}
