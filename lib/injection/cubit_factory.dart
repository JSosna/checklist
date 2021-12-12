import 'package:checklist/presentation/checklists/list/checklists_loader_cubit/cubit/checklists_loader_cubit.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/presentation/groups/list/groups_loader_cubit/groups_loader_cubit.dart';
import 'package:checklist/presentation/groups/picker/cubit/group_picker_cubit.dart';
import 'package:checklist/presentation/groups/picker/group_picker_loader_cubit/group_picker_loader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CubitFactory {
  final GetIt injector;

  const CubitFactory({
    required this.injector,
  });

  T get<T extends Cubit>() => injector.get<T>();

  static CubitFactory of(BuildContext context, {bool listen = true}) =>
      Provider.of<CubitFactory>(context, listen: listen);

  ChecklistsCubit getChecklistsCubit(ChecklistsLoaderCubit checklistsLoaderCubit) => injector.get(param1: checklistsLoaderCubit);
  GroupsCubit getGroupsCubit(GroupsLoaderCubit groupsLoaderCubit) => injector.get(param1: groupsLoaderCubit);
  GroupPickerCubit getGroupPickerCubit(GroupPickerLoaderCubit groupPickerLoaderCubit) => injector.get(param1: groupPickerLoaderCubit);
}
