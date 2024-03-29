import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/presentation/groups/details/cubit/group_details_cubit.dart';
import 'package:checklist/presentation/groups/details/widgets/group_member_list_item.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_dialog_menu_item.dart';
import 'package:checklist/widgets/checklist_editable_label.dart';
import 'package:checklist/widgets/checklist_error_view.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:checklist/widgets/checklist_loading_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

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

class _GroupDetailsPageState extends State<GroupDetailsPage>
    with SingleTickerProviderStateMixin {
  bool _showMoreMenu = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupDetailsCubit>(context).loadDetails(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsCubit, GroupDetailsState>(
      listener: (context, state) {
        if (state is LeftGroup) {
          context.router.pop(true);
        }
      },
      buildWhen: (previous, current) => current is! LeftGroup,
      builder: (context, state) {
        if (state is GroupDetailsLoading) {
          return const ChecklistLoadingView();
        } else if (state is GroupDetailsLoaded) {
          return _buildDetails(state);
        } else {
          return ChecklistErrorView(
            message: LocaleKeys.groups_error_loading_details.tr(),
          );
        }
      },
    );
  }

  Widget _buildDetails(GroupDetailsLoaded state) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildTopPart(state),
              Expanded(child: _buildTabs(state)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTopPart(GroupDetailsLoaded state) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.router.pop(true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                LocaleKeys.general_group.tr(),
                style: context.typo.extraLargeBold(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          _buildMoreButton(state),
        ],
      ),
      const SizedBox(height: Dimens.marginLarge),
      Align(
        child: ChecklistEditableLabel(
          text: state.detailedGroup.group.name ?? "",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
          onChanged: (newText) {
            BlocProvider.of<GroupDetailsCubit>(context)
                .changeName(widget.groupId, newText);
          },
        ),
      ),
      const SizedBox(height: Dimens.marginLarge),
      const Divider(height: 0, thickness: 2.0),
    ];
  }

  Widget _buildMoreButton(GroupDetailsLoaded state) {
    return PortalEntry(
      visible: _showMoreMenu,
      portal: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _showMoreMenu = false;
          });
        },
      ),
      child: PortalEntry(
        visible: _showMoreMenu,
        portalAnchor: Alignment.topRight,
        childAnchor: Alignment.center,
        portal: _buildMoreMenu(state),
        child: IconButton(
          onPressed: () {
            setState(() {
              _showMoreMenu = !_showMoreMenu;
            });
          },
          icon: const Icon(Icons.more_vert),
        ),
      ),
    );
  }

  Widget _buildMoreMenu(GroupDetailsLoaded state) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChecklistDialogMenuItem(
              text: LocaleKeys.general_share.tr(),
              onPressed: () {
                context.router.push(ShareGroupRoute(groupId: widget.groupId));
              },
            ),
            ChecklistDialogMenuItem(
              text: LocaleKeys.groups_leave_group.tr(),
              enabled: !state.detailedGroup.isCurrentUserAdmin,
              onPressed: () {
                BlocProvider.of<GroupDetailsCubit>(context)
                    .leaveGroup(widget.groupId);
              },
            ),
            ChecklistDialogMenuItem(
              text: LocaleKeys.groups_delete_group.tr(),
              enabled: state.detailedGroup.isCurrentUserAdmin,
              onPressed: () {
                BlocProvider.of<GroupDetailsCubit>(context)
                    .deleteGroup(widget.groupId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(GroupDetailsLoaded state) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            indicatorColor: context.isDarkTheme ? Colors.white : Colors.black,
            labelColor: context.isDarkTheme ? Colors.white : Colors.black,
            tabs: [
              Tab(text: LocaleKeys.general_lists.tr()),
              Tab(text: LocaleKeys.groups_members.tr())
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildListsTab(state),
                _buildMembersTab(state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListsTab(GroupDetailsLoaded state) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: state.detailedGroup.checklists.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.marginMedium),
              child: ChecklistListItem(
                onPressed: () {
                  final checklistId = state.detailedGroup.checklists[index].id;

                  if (checklistId != null) {
                    context.router
                        .push(ChecklistDetailsRoute(checklistId: checklistId));
                  }
                },
                child: Row(
                  children: [
                    Text(state.detailedGroup.checklists[index].name ?? ""),
                  ],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimens.marginLarge),
            child: FloatingActionButton.extended(
              backgroundColor:
                  context.isDarkTheme ? Colors.white : Colors.black,
              heroTag: "group details add checklist",
              onPressed: () async {
                final shouldUpdate = await context.router.push(
                  AddChecklistRoute(
                    initialGroup: state.detailedGroup.group,
                  ),
                );

                if (shouldUpdate == true) {
                  if (!mounted) return;

                  try {
                    BlocProvider.of<GroupDetailsCubit>(context)
                        .loadDetails(widget.groupId);
                  } catch (e) {
                    Fimber.d("BlocProvider error");
                  }
                }
              },
              label: Text(LocaleKeys.checklist_create_new_checklist.tr()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersTab(GroupDetailsLoaded state) {
    return ListView.builder(
      itemCount: state.detailedGroup.members.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.marginMedium),
          child: GroupMemberListItem(
            name: state.detailedGroup.members[index].name ?? "",
            isCurrentUser:
                state.currentUserId == state.detailedGroup.members[index].uid,
            onDelete: () {
              final memberId = state.detailedGroup.members[index].uid;

              if (memberId != null) {
                BlocProvider.of<GroupDetailsCubit>(context)
                    .removeMember(widget.groupId, memberId);
              }
            },
            onHandOverAdmin: () {
              final memberId = state.detailedGroup.members[index].uid;

              if (memberId != null) {
                BlocProvider.of<GroupDetailsCubit>(context)
                    .handOverAdmin(widget.groupId, memberId);
              }
            },
            isCurrentUserAdmin: state.detailedGroup.isCurrentUserAdmin,
          ),
        );
      },
    );
  }
}
