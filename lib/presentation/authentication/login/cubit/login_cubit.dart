import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(LoginInitial());

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
}
