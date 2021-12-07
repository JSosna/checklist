part of 'checklist_details_cubit.dart';

abstract class ChecklistDetailsState extends Equatable {
  const ChecklistDetailsState();

  @override
  List<Object> get props => [];
}

class ChecklistDetailsLoading extends ChecklistDetailsState {}

class ChecklistDetailsLoaded extends ChecklistDetailsState {
  final Checklist checklist;

  const ChecklistDetailsLoaded({required this.checklist});

  @override
  List<Object> get props => [checklist];
}

class ChecklistDetailsError extends ChecklistDetailsState {}
