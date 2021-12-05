import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/details/cubit/group_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String groupId;

  const GroupDetailsPage({required this.groupId});

  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final GroupDetailsCubit groupDetailsCubit = cubitFactory.get();

    return BlocProvider<GroupDetailsCubit>(
      create: (context) => groupDetailsCubit,
      child: this,
    );
  }

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsCubit, GroupDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text("Group details: ${widget.groupId}"),
          ),
        );
      },
    );
  }
}
