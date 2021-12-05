part of 'add_group_cubit.dart';

abstract class AddGroupState extends Equatable {
  const AddGroupState();

  @override
  List<Object> get props => [];
}

class AddGroupInitial extends AddGroupState {}

class AddedUserToGroup extends AddGroupState {}

class CreatedNewGroup extends AddGroupState {}

class ErrorWhileAddingUserToGroup extends AddGroupState {}

class ErrorWhileCreatingGroup extends AddGroupState {}
