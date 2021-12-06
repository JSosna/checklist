part of 'add_checklist_cubit.dart';

abstract class AddChecklistState extends Equatable {
  const AddChecklistState();

  @override
  List<Object> get props => [];
}

class AddChecklistInitial extends AddChecklistState {}

class CreatedNewChecklist extends AddChecklistState {}

class ErrorWhileCreatingChecklist extends AddChecklistState {}
