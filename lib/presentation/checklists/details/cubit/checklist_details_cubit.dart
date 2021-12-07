import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checklist_details_state.dart';

class ChecklistDetailsCubit extends Cubit<ChecklistDetailsState> {
  ChecklistDetailsCubit() : super(ChecklistDetailsInitial());
}
