part of 'groups_loader_cubit.dart';

abstract class GroupsLoaderState extends Equatable {
  const GroupsLoaderState();

  @override
  List<Object> get props => [];
}

class GroupsLoaderIdle extends GroupsLoaderState {}

class GroupsLoaderLoading extends GroupsLoaderState {}

class GroupsLoaderLoaded extends GroupsLoaderState {
  final List<Group> groups;

  const GroupsLoaderLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}
