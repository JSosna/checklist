import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription _refreshSubscription;

  AuthenticationCubit(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    _refreshSubscription =
        _authenticationRepository.userStream().listen((user) {
      if (user != null) {
        emit(UserLoggedIn());
      } else {
        emit(UserLoggedOut());
      }
    });
  }

  @override
  Future<void> close() {
    _refreshSubscription.cancel();
    return super.close();
  }
}
