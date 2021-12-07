part of 'checklists_cubit.dart';

abstract class ChecklistsState extends Equatable {
  const ChecklistsState();

  @override
  List<Object> get props => [];
}

class ChecklistsLoading extends ChecklistsState {}

class ChecklistsLoaded extends ChecklistsState {
  final List<Checklist> checklists;

  const ChecklistsLoaded(this.checklists);
}

class ChecklistLoadingError extends ChecklistsState {}
