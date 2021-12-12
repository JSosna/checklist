part of 'group_picker_loader_cubit.dart';

abstract class GroupPickerLoaderState extends Equatable {
  const GroupPickerLoaderState();

  @override
  List<Object> get props => [];
}

class GroupPickerLoaderIdle extends GroupPickerLoaderState {}

class GroupPickerLoaderLoading extends GroupPickerLoaderState {}

class GroupPickerLoaderLoaded extends GroupPickerLoaderState {
  final List<Group> groups;

  const GroupPickerLoaderLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}
