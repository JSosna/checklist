import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/checklists/details/cubit/checklist_details_cubit.dart';
import 'package:checklist/widgets/checklist_editable_label.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

class ChecklistDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String checklistId;

  const ChecklistDetailsPage({required this.checklistId});

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
  bool _showMoreMenu = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChecklistDetailsCubit>(context)
        .loadDetails(widget.checklistId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChecklistDetailsCubit, ChecklistDetailsState>(
      listener: (context, state) {
        if (state is ChecklistDeleted) {
          context.router.pop(true);
        }
      },
      buildWhen: (previous, current) => current is! ChecklistDeleted,
      builder: (context, state) {
        return _buildPage(state);
      },
    );
  }

  Widget _buildPage(ChecklistDetailsState state) {
    if (state is ChecklistDetailsLoading) {
      return _buildLoading();
    } else if (state is ChecklistDetailsLoaded) {
      return _buildDetails(state);
    } else {
      return _buildError();
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      key: ValueKey("loading"),
      body: Center(
        child: ChecklistLoadingIndicator(),
      ),
    );
  }

  Widget _buildDetails(ChecklistDetailsLoaded state) {
    return Scaffold(
      key: const ValueKey("details"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildTopPart(state),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTopPart(ChecklistDetailsLoaded state) {
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
          _buildMoreButton(state),
        ],
      ),
      Align(
        child: ChecklistEditableLabel(
          text: state.checklist.name ?? "",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
          onChanged: (newText) {
            BlocProvider.of<ChecklistDetailsCubit>(context)
                .changeName(widget.checklistId, newText);
          },
        ),
      ),
    ];
  }

  Widget _buildMoreButton(ChecklistDetailsLoaded state) {
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

  Widget _buildMoreMenu(ChecklistDetailsLoaded state) {
    return Material(
      elevation: 8,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('delete list'),
              enabled: state.isUserAdmin,
              onTap: () {
                final groupId = state.checklist.assignedGroupId;

                if (groupId != null) {
                  BlocProvider.of<ChecklistDetailsCubit>(context)
                      .deleteChecklist(
                    widget.checklistId,
                    groupId,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return const Scaffold(
      key: ValueKey("error"),
      body: Center(
        child: Text(
          "Error while loading the list, check your internet connection or try later",
        ),
      ),
    );
  }
}
