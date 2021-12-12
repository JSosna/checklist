part of 'checklists_loader_cubit.dart';

abstract class ChecklistsLoaderState extends Equatable {
  const ChecklistsLoaderState();

  @override
  List<Object> get props => [];
}

class ChecklistsLoaderIdle extends ChecklistsLoaderState {}

class ChecklistsLoaderLoading extends ChecklistsLoaderState {}

class ChecklistsLoaderLoaded extends ChecklistsLoaderState {
  final List<GroupWithChecklists> groupsWithChecklists;

  const ChecklistsLoaderLoaded(this.groupsWithChecklists);

  @override
  List<Object> get props => [groupsWithChecklists];
}
