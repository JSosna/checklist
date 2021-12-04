import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/add/cubit/add_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final AddGroupCubit addGroupCubit = cubitFactory.get();

    return BlocProvider<AddGroupCubit>(
      create: (context) => addGroupCubit,
      child: this,
    );
  }

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text("Add Group Page"),
          ),
        );
      },
    );
  }
}
