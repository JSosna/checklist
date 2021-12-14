import 'package:bloc/bloc.dart';
import 'package:checklist/domain/settings/checklist_settings.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SettingsStorage _settingsStorage;

  OnboardingCubit(this._settingsStorage) : super(OnboardingLoading());

  Future<void> initializeSettings() async {
    emit(OnboardingLoaded(settings: _settingsStorage.getAppSettings()));
  }

  Future<void> setBiometrics() async {
    final settings = await _settingsStorage.toggleBiometricsOption();
    
    emit(OnboardingLoaded(settings: settings));
  }
}
