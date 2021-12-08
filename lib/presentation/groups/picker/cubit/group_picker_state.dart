part of 'group_picker_cubit.dart';

abstract class GroupPickerState extends Equatable {
  const GroupPickerState();

  @override
  List<Object> get props => [];
}

class GroupPickerLoading extends GroupPickerState {}

class GroupPickerLoaded extends GroupPickerState {
  final List<Group> groups;

  const GroupPickerLoaded({required this.groups});
}

class GroupPickerError extends GroupPickerState {}
