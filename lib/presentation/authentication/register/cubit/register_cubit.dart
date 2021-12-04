import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/authentication/authentication_result.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository _authenticationRepository;

  RegisterCubit(this._authenticationRepository) : super(RegisterInitial());

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    final response = await _authenticationRepository.register(
      username: username,
      email: email,
      password: password,
    );

    if (response is AuthenticationSuccess) {
      emit(RegisterSuccess());
    } else if (response is AuthenticationError) {
      emit(RegisterError(authenticationError: response.authenticationError));
    }
  }
}
