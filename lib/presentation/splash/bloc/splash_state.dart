part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  
  @override
  List<Object> get props => [];
}

class Loading extends SplashState {}

class OpenHome extends SplashState {}

class OpenLogin extends SplashState {}
