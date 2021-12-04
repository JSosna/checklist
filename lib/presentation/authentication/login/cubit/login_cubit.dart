import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final SettingsStorage _settingsStorage;

  LoginCubit(this._authenticationRepository, this._settingsStorage)
      : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final response =
        await _authenticationRepository.login(email: email, password: password);

    if (response is AuthenticationSuccess) {
      emit(LoginSuccess());
    } else if (response is AuthenticationError) {
      emit(LoginError(authenticationError: response.authenticationError));
    }
  }

  Future<void> tryToAuthenticateUsingBiometrics() async {
    if (_settingsStorage.isBiometricsActive() &&
        _authenticationRepository.getCurrentUser() != null) {
      final authResult =
          await _authenticationRepository.authenticateUsingBiometrics(
        translate(LocaleKeys.authentication_biometrics_auth_reason),
      );

      if (authResult) {
        emit(BiometricAuthenticationSuccess());
      }
    }
  }
}
