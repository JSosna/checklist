import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/checklists/details/cubit/checklist_details_cubit.dart';
import 'package:checklist/presentation/checklists/details/widgets/checklist_elements.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_dialog_menu_item.dart';
import 'package:checklist/widgets/checklist_editable_label.dart';
import 'package:checklist/widgets/checklist_error_view.dart';
import 'package:checklist/widgets/checklist_loading_view.dart';
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
      return const ChecklistLoadingView();
    } else if (state is ChecklistDetailsLoaded) {
      return _buildDetails(state);
    } else {
      return const ChecklistErrorView(
        message:
            "Error while loading the list, check your internet connection or try later",
      );
    }
  }

  Widget _buildDetails(ChecklistDetailsLoaded state) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildTopPart(state),
              Expanded(
                child: ChecklistElements(
                  elements: state.checklist.elements ?? [],
                  checkable: state.checklist.checkable,
                  onItemsUpdated: (updatedList) {
                    BlocProvider.of<ChecklistDetailsCubit>(context)
                        .updateItems(state, updatedList, widget.checklistId);
                  },
                ),
              ),
            ],
          ),
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
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "List",
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
          text: state.checklist.name ?? "",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
          onChanged: (newText) {
            BlocProvider.of<ChecklistDetailsCubit>(context)
                .changeName(widget.checklistId, newText.trim());
          },
        ),
      ),
      const SizedBox(height: Dimens.marginLarge),
      const Divider(height: 0.0, thickness: 2.0),
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
      borderRadius: BorderRadius.circular(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChecklistDialogMenuItem(
              text: "toggle checkboxes",
              onPressed: () {
                BlocProvider.of<ChecklistDetailsCubit>(context).toggleCheckable(
                  widget.checklistId,
                  isUserAdmin: state.isUserAdmin,
                );

                setState(() {
                  _showMoreMenu = false;
                });
              },
            ),
            ChecklistDialogMenuItem(
              text: "delete list",
              onPressed: () {
                final groupId = state.checklist.assignedGroupId;

                if (groupId != null) {
                  BlocProvider.of<ChecklistDetailsCubit>(context)
                      .deleteChecklist(
                    widget.checklistId,
                    groupId,
                  );
                }

                setState(() {
                  _showMoreMenu = false;
                });
              },
              enabled: state.isUserAdmin,
            ),
          ],
        ),
      ),
    );
  }
}
