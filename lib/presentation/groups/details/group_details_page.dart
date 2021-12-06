import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/details/cubit/group_details_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_editable_label.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
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
          return _buildLoading();
        } else if (state is GroupDetailsLoaded) {
          return _buildDetails(state);
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

  Widget _buildDetails(GroupDetailsLoaded state) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildTopPart(state),
            const SizedBox(height: Dimens.kMarginLarge),
            const Divider(height: 0),
            Expanded(child: _buildTabs(state)),
          ],
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
          _buildMoreButton(),
        ],
      ),
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
    ];
  }

  Widget _buildMoreButton() {
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
        portal: _buildMoreMenu(),
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

  Widget _buildMoreMenu() {
    return Material(
      elevation: 8,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('leave group'),
              onTap: () {
                BlocProvider.of<GroupDetailsCubit>(context)
                    .leaveGroup(widget.groupId);
              },
            ),
            ListTile(
              title: const Text('delete group'),
              onTap: () {
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
          const TabBar(
            tabs: [Tab(text: "lists"), Tab(text: "members")],
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
    return ListView.builder(
      itemCount: state.detailedGroup.checklists.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.kMarginLarge),
          child: ListTile(
            tileColor: Colors.black,
            title: Text(state.detailedGroup.members[index].name ?? ""),
          ),
        );
      },
    );
  }

  Widget _buildMembersTab(GroupDetailsLoaded state) {
    return ListView.builder(
      itemCount: state.detailedGroup.members.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.kMarginLarge),
          child: ListTile(
            tileColor: Colors.black,
            title: Text(state.detailedGroup.members[index].name ?? ""),
          ),
        );
      },
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
}
