part of 'share_group_cubit.dart';

abstract class ShareGroupState extends Equatable {
  const ShareGroupState();

  @override
  List<Object> get props => [];
}

class ShareGroupLoading extends ShareGroupState {}

class ShareGroupLoaded extends ShareGroupState {
  final String shareCode;

  const ShareGroupLoaded(this.shareCode);

  @override
  List<Object> get props => [shareCode];
}

class ShareGroupError extends ShareGroupState {}
