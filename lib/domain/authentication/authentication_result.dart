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
  final String message;

  const AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}
