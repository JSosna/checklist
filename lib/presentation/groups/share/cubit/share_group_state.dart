part of 'share_group_cubit.dart';

abstract class ShareGroupState extends Equatable {
  const ShareGroupState();

  @override
  List<Object> get props => [];
}

class ShareGroupLoading extends ShareGroupState {}

class ShareGroupLoaded extends ShareGroupState {
  final String joinCode;

  const ShareGroupLoaded(this.joinCode);

  @override
  List<Object> get props => [joinCode];
}

class ShareGroupError extends ShareGroupState {}
