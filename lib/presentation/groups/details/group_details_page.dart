import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/details/cubit/group_details_cubit.dart';
import 'package:checklist/widgets/checklist_editable_label.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<GroupDetailsCubit>(context).loadDetails(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsCubit, GroupDetailsState>(
      listener: (context, state) {},
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
            IconButton(
              onPressed: () {
                context.router.pop(true);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Align(
              child: ChecklistEditableLabel(
                text: state.group.name ?? "",
                style: context.typo.largeBold(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
                onChanged: (newText) {
                  BlocProvider.of<GroupDetailsCubit>(context)
                      .changeName(widget.groupId, newText);
                },
              ),
            ),
            const Divider()
          ],
        ),
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
}
