import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/checklists/details/cubit/checklist_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final ChecklistDetailsCubit checklistDetailsCubit = cubitFactory.get();

    return BlocProvider<ChecklistDetailsCubit>(
      create: (context) => checklistDetailsCubit,
      child: this,
    );
  }

  @override
  _ChecklistDetailsPageState createState() => _ChecklistDetailsPageState();
}

class _ChecklistDetailsPageState extends State<ChecklistDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Checklist details"),
      ),
    );
  }
}
