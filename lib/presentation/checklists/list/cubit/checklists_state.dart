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
}

class ChecklistLoadingError extends ChecklistsState {}
