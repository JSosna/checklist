import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/presentation/groups/list/groups_loader_cubit/groups_loader_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_empty_list_view.dart';
import 'package:checklist/widgets/checklist_error_view.dart';
import 'package:checklist/widgets/checklist_group_icon.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_loading_view.dart';
import 'package:checklist/widgets/checklist_page_title.dart';
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
          return const ChecklistLoadingView();
        } else if (state is GroupsLoaded || state is GroupsEmpty) {
          return _buildContent(state);
        } else {
          return const ChecklistErrorView(
            message:
                "Error while loading the list, check your internet connection or try later",
          );
        }
      },
    );
  }

  Widget _buildContent(GroupsState state) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.isDarkTheme ? Colors.white : Colors.black,
          heroTag: "add group",
          child: const Icon(Icons.add),
          onPressed: () async {
            final shouldUpdate =
                await context.router.push(const AddGroupRoute());

            if (shouldUpdate == true) {
              if (!mounted) return;

              try {
                BlocProvider.of<GroupsLoaderCubit>(context).reloadGroups();
              } catch (e) {
                Fimber.d("BlocProvider error");
              }
            }
          },
        ),
        body: Center(
          child: state is GroupsLoaded
              ? _buildGroupsNotEmptyView(state)
              : _buildEmptyView(),
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Padding(
      padding: EdgeInsets.all(Dimens.marginMedium),
      child: ChecklistEmptyListView(
        hint: "Create a new group!",
      ),
    );
  }

  Widget _buildGroupsNotEmptyView(GroupsLoaded state) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: Dimens.marginLarge),
          const ChecklistPageTitle("groups"),
          const SizedBox(height: Dimens.marginMedium),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.marginMedium),
              child: Stack(
                children: [
                  _buildList(state),
                  BlocBuilder<GroupsLoaderCubit, GroupsLoaderState>(
                    builder: (context, state) {
                      if (state is GroupsLoaderLoading) {
                        return const Center(child: ChecklistLoadingIndicator());
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(GroupsLoaded state) {
    return RefreshIndicator(
      color: context.isDarkTheme ? Colors.white : Colors.black,
      onRefresh: () async {
        await BlocProvider.of<GroupsLoaderCubit>(context).reloadGroups();
      },
      child: ListView.builder(
        itemCount: state.groups.length,
        itemBuilder: (context, index) {
          return _buildElement(context, state, index);
        },
      ),
    );
  }

  Widget _buildElement(BuildContext context, GroupsLoaded state, int index) {
    return ChecklistListItem(
      leading: ChecklistGroupIcon(
        group: state.groups[index],
      ),
      onPressed: () async {
        final groupId = state.groups[index].id;

        if (groupId != null) {
          final shouldUpdate =
              await context.router.push(GroupDetailsRoute(groupId: groupId));

          if (shouldUpdate == true) {
            if (!mounted) return;

            try {
              BlocProvider.of<GroupsLoaderCubit>(context).reloadGroups();
            } catch (e) {
              Fimber.d("BlocProvider error");
            }
          }
        }
      },
      child: Text(state.groups[index].name ?? ""),
    );
  }
}
