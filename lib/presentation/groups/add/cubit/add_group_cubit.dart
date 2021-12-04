import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_group_state.dart';

class AddGroupCubit extends Cubit<AddGroupState> {
  AddGroupCubit() : super(AddGroupInitial());
}
