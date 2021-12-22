part of 'groups_cubit.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<Group> groups;

  const GroupsLoaded(this.groups);

  @override
  List<Object> get props => [groups];
}

class GroupsEmpty extends GroupsState {}

class GroupsError extends GroupsState {}
