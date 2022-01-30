import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenticationRepository _authenticationRepository;

  SplashBloc(this._authenticationRepository)
      : super(Loading()) {
    on<InitializeApplication>((event, emit) async {
      emit(Loading());

      final user = _authenticationRepository.getCurrentUser();

      if (user == null) {
        emit(OpenLogin());
      } else {
        emit(OpenHome());
      }
    });
  }
}
