import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AuthenticationRepository _authenticationRepository;

  SettingsCubit(this._authenticationRepository) : super(SettingsInitial());

  void logout() {
    _authenticationRepository.logout();
  }
}
