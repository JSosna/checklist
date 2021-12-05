import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final GroupsCubit groupsCubit = cubitFactory.get();

    return BlocProvider<GroupsCubit>(
      create: (context) => groupsCubit,
      child: this,
    );
  }

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupsCubit>(context).loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return _buildLoading();
        } else if (state is GroupsLoaded) {
          return _buildContent(state);
        } else {
          return _buildError();
        }
      },
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: ChecklistLoadingIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Error while loading the list, check your internet connection or try later",
        ),
      ),
    );
  }

  Widget _buildContent(GroupsLoaded state) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final shouldUpdate = await context.router.push(const AddGroupRoute());

          if (shouldUpdate == true) {
            if (!mounted) return;
            BlocProvider.of<GroupsCubit>(context).loadGroups();
          }
        },
      ),
      body: Center(
        child: ListView.builder(
          itemCount: state.groups.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Colors.grey,
              title: Text(state.groups[index].name ?? ""),
              onTap: () {
                final groupId = state.groups[index].id;

                if (groupId != null) {
                  context.router.push(GroupDetailsRoute(groupId: groupId));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
