part of 'checklists_cubit.dart';

abstract class ChecklistsState extends Equatable {
  const ChecklistsState();

  @override
  List<Object> get props => [];
}

class ChecklistsLoading extends ChecklistsState {}

class ChecklistsLoaded extends ChecklistsState {
  final List<GroupWithChecklists> groupsWithChecklists;

  const ChecklistsLoaded(this.groupsWithChecklists);

  @override
  List<Object> get props => [groupsWithChecklists];
}

class ChecklistsEmpty extends ChecklistsState {}

class ChecklistLoadingError extends ChecklistsState {}
