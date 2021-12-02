import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/domain/authentication/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationResponse extends Equatable {
  const AuthenticationResponse();

  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationResponse {
  final User user;

  const AuthenticationSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthenticationResponse {
  final AuthenticationErrorType authenticationError;

  const AuthenticationError({required this.authenticationError});

  @override
  List<Object> get props => [authenticationError];
}
