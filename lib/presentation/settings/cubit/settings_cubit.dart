import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/settings/checklist_settings.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:checklist/domain/users/use_case/change_username_use_case.dart';
import 'package:checklist/domain/users/use_case/delete_account_use_case.dart';
import 'package:checklist/domain/users/user.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AuthenticationRepository _authenticationRepository;
  final SettingsStorage _settingsStorage;
  final ChangeUsernameUseCase _changeUsernameUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  SettingsCubit(
    this._authenticationRepository,
    this._settingsStorage,
    this._changeUsernameUseCase,
    this._deleteAccountUseCase,
  ) : super(SettingsInitializing());

  Future<void> initializeSettings() async {
    final settings = _settingsStorage.getAppSettings();
    final user = _authenticationRepository.getCurrentUser();
    emit(SettingsLoaded(settings: settings, user: user));
  }

  Future<void> toggleBiometricsOption(User? user) async {
    emit(SettingsUpdating());

    final settings = await _settingsStorage.toggleBiometricsOption();

    emit(SettingsLoaded(settings: settings, user: user));
  }

  void logout() {
    _authenticationRepository.logout();
  }

  Future<void> changeUsername(String newUsername) async {
    await _changeUsernameUseCase.changeUsername(username: newUsername);
  }

  Future<void> deleteAccount() async {
    emit(SettingsInitializing());
    await _deleteAccountUseCase.deleteAccount();
  }
}
