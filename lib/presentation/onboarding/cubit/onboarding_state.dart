part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final ChecklistSettings settings;

  const OnboardingLoaded({required this.settings});

  @override
  List<Object> get props => [settings];
}
