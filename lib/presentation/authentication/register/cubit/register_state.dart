part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final AuthenticationErrorType authenticationError;

  const RegisterError({required this.authenticationError});

  @override
  List<Object> get props => [authenticationError];
}
