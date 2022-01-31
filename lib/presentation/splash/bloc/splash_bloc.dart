import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenticationRepository _authenticationRepository;
  final SettingsStorage _settingsStorage;

  SplashBloc(this._authenticationRepository, this._settingsStorage)
      : super(Loading()) {
    on<InitializeApplication>((event, emit) async {
      emit(Loading());

      final user = _authenticationRepository.getCurrentUser();
      final canUseBiometrics = await _authenticationRepository
          .canDeviceAuthenticateUsingBiometrics();
      final isBiometricsActive = _settingsStorage.isBiometricsActive();

      if (user == null || (canUseBiometrics && isBiometricsActive)) {
        emit(OpenLogin());
      } else {
        emit(OpenHome());
      }
    });
  }
}
