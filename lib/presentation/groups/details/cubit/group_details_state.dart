part of 'group_details_cubit.dart';

abstract class GroupDetailsState extends Equatable {
  const GroupDetailsState();

  @override
  List<Object> get props => [];
}

class GroupDetailsInitial extends GroupDetailsState {}

class GroupDetailsLoading extends GroupDetailsState {}

class GroupDetailsLoaded extends GroupDetailsState {
  final DetailedGroup detailedGroup;
  final String currentUserId;

  const GroupDetailsLoaded({
    required this.detailedGroup,
    required this.currentUserId,
  });

  @override
  List<Object> get props => [detailedGroup, currentUserId];
}

class LeftGroup extends GroupDetailsState {}

class GroupDetailsError extends GroupDetailsState {}
