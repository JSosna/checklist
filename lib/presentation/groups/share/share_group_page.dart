import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/share/cubit/share_group_cubit.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareGroupPage extends StatefulWidget implements AutoRouteWrapper {
  final String groupId;

  const ShareGroupPage({required this.groupId});

  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final ShareGroupCubit shareGroupCubit = cubitFactory.get();

    return BlocProvider<ShareGroupCubit>(
      create: (context) => shareGroupCubit,
      child: this,
    );
  }

  @override
  State<ShareGroupPage> createState() => _ShareGroupPageState();
}

class _ShareGroupPageState extends State<ShareGroupPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShareGroupCubit>(context).loadShareCode(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareGroupCubit, ShareGroupState>(
      builder: (context, state) {
        if (state is ShareGroupLoading) {
          return _buildLoading();
        } else if (state is ShareGroupLoaded) {
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

  Widget _buildContent(ShareGroupLoaded state) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Center(child: Text(state.joinCode)),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Error, check your internet connection or try later",
        ),
      ),
    );
  }
}
