import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checklists_state.dart';

class ChecklistsCubit extends Cubit<ChecklistsState> {
  ChecklistsCubit() : super(ChecklistsInitial());
}
