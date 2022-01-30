import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/checklists/checklist.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/presentation/checklists/list/checklists_loader_cubit/cubit/checklists_loader_cubit.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_empty_list_view.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_page_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
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
    BlocProvider.of<ChecklistsLoaderCubit>(context).reloadChecklists();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsCubit, ChecklistsState>(
      builder: (context, state) {
        if (state is ChecklistsLoading) {
          return _buildLoader();
        } else if (state is ChecklistsLoaded || state is ChecklistsEmpty) {
          return _buildContent(state);
        } else {
          return _buildError();
        }
      },
    );
  }

  Widget _buildLoader() {
    return const ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: ChecklistLoadingIndicator()),
      ),
    );
  }

  Widget _buildContent(ChecklistsState state) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.isDarkTheme ? Colors.white : Colors.black,
          heroTag: "add checklist",
          child: const Icon(Icons.add),
          onPressed: () async {
            final reload = await context.router.push(AddChecklistRoute());
            if (reload == true) {
              if (!mounted) return;
              await BlocProvider.of<ChecklistsLoaderCubit>(context)
                  .reloadChecklists();
            }
          },
        ),
        body: state is ChecklistsLoaded
            ? _buildChecklistsNotEmptyView(state)
            : _buildEmptyView(),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.marginMedium),
        child: ChecklistEmptyListView(
          hint: LocaleKeys.checklist_create_new_checklist.tr(),
        ),
      ),
    );
  }

  Widget _buildChecklistsNotEmptyView(ChecklistsLoaded state) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: Dimens.marginLarge),
          ChecklistPageTitle(LocaleKeys.general_lists.tr()),
          const SizedBox(height: Dimens.marginMedium),
          Expanded(
            child: Stack(
              children: [
                _buildList(state),
                BlocBuilder<ChecklistsLoaderCubit, ChecklistsLoaderState>(
                  builder: (context, state) {
                    if (state is ChecklistsLoaderLoading) {
                      return const Center(
                        child: ChecklistLoadingIndicator(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(ChecklistsLoaded state) {
    return RefreshIndicator(
      color: context.isDarkTheme ? Colors.white : Colors.black,
      onRefresh: () async {
        await BlocProvider.of<ChecklistsLoaderCubit>(context)
            .reloadChecklists();
      },
      child: ListView.builder(
        itemCount: state.groupsWithChecklists.length,
        itemBuilder: (context, index) {
          if (state.groupsWithChecklists[index].checklists.isNotEmpty) {
            return ExpansionTile(
              initiallyExpanded: true,
              title: Text(state.groupsWithChecklists[index].group.name ?? ""),
              children: state.groupsWithChecklists[index].checklists
                  .map(_buildListItem)
                  .toList(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildListItem(Checklist checklist) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.marginMedium,
        right: Dimens.marginMedium,
        bottom: Dimens.marginMedium,
      ),
      child: ChecklistListItem(
        child: Text(checklist.name ?? ""),
        onPressed: () async {
          final checklistId = checklist.id;

          if (checklistId != null) {
            final shouldUpdate = await context.router.push(
              ChecklistDetailsRoute(checklistId: checklistId),
            );

            if (shouldUpdate == true) {
              if (!mounted) return;
              try {
                BlocProvider.of<ChecklistsLoaderCubit>(context)
                    .reloadChecklists();
              } catch (e) {
                Fimber.d("BlocProvider error");
              }
            }
          }
        },
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      body: Center(child: Text(LocaleKeys.checklist_error_loading_list.tr())),
    );
  }
}
