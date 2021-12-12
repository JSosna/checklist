part of 'checklist_details_cubit.dart';

abstract class ChecklistDetailsState extends Equatable {
  const ChecklistDetailsState();

  @override
  List<Object> get props => [];
}

class ChecklistDetailsLoading extends ChecklistDetailsState {}

class ChecklistDetailsLoaded extends ChecklistDetailsState {
  final Checklist checklist;
  final bool isUserAdmin;

  const ChecklistDetailsLoaded({
    required this.checklist,
    required this.isUserAdmin,
  });

  @override
  List<Object> get props => [checklist, isUserAdmin];
}

class ChecklistDetailsError extends ChecklistDetailsState {}

class ChecklistDeleted extends ChecklistDetailsState {}
