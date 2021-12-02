part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final AuthenticationErrorType authenticationError;

  const LoginError({required this.authenticationError});

  @override
  List<Object> get props => [authenticationError];
}
