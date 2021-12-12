import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistsPage extends StatefulWidget {
  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChecklistsCubit>(context).loadChecklists();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsCubit, ChecklistsState>(
      builder: (context, state) {
        return _buildPage(state);
      },
    );
  }

  Widget _buildLoader() {
    return const Scaffold(
      key: ValueKey("loading"),
      body: Center(child: ChecklistLoadingIndicator()),
    );
  }

  Widget _buildContent(ChecklistsLoaded state) {
    return Scaffold(
      key: const ValueKey("content"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(AddChecklistRoute());
        },
      ),
      body: ListView.builder(
        itemCount: state.checklists.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.grey.withOpacity(0.5),
            title: Text(state.checklists[index].name ?? ""),
            onTap: () async {
              final checklistId = state.checklists[index].id;

              if (checklistId != null) {
                final shouldUpdate = await context.router.push(
                  ChecklistDetailsRoute(checklistId: checklistId),
                );

                if (shouldUpdate == true) {
                  if (!mounted) return;
                  BlocProvider.of<ChecklistsCubit>(context).loadChecklists();
                }
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildError() {
    return const Scaffold(
      key: ValueKey("error"),
      body: Center(child: Text("Error loading list, try again later!")),
    );
  }

  Widget _buildPage(ChecklistsState state) {
    if (state is ChecklistsLoading) {
      return _buildLoader();
    } else if (state is ChecklistsLoaded) {
      return _buildContent(state);
    } else {
      return _buildError();
    }
  }
}
