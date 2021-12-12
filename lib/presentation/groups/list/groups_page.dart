import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/widgets/checklist_group_icon.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatefulWidget {
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
        heroTag: "add group",
        child: const Icon(Icons.add),
        onPressed: () async {
          final shouldUpdate = await context.router.push(const AddGroupRoute());

          if (shouldUpdate == true) {
            if (!mounted) return;

            try {
              BlocProvider.of<GroupsCubit>(context).loadGroups();
            } catch (e) {
              Fimber.d("BlocProvider error");
            }
          }
        },
      ),
      body: Center(
        child: ListView.builder(
          itemCount: state.groups.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ChecklistGroupIcon(
                group: state.groups[index],
              ),
              tileColor: Colors.grey.withOpacity(0.5),
              title: Text(state.groups[index].name ?? ""),
              onTap: () async {
                final groupId = state.groups[index].id;

                if (groupId != null) {
                  final shouldUpdate = await context.router
                      .push(GroupDetailsRoute(groupId: groupId));

                  if (shouldUpdate == true) {
                    if (!mounted) return;

                    try {
                      BlocProvider.of<GroupsCubit>(context).loadGroups();
                    } catch (e) {
                      Fimber.d("BlocProvider error");
                    }
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
