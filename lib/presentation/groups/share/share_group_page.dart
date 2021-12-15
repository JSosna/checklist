import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/share/cubit/share_group_cubit.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_error_view.dart';
import 'package:checklist/widgets/checklist_loading_view.dart';
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
          return const ChecklistLoadingView();
        } else if (state is ShareGroupLoaded) {
          return _buildContent(state);
        } else {
          return const ChecklistErrorView(
            message: "Error, check your internet connection or try later",
          );
        }
      },
    );
  }

  Widget _buildContent(ShareGroupLoaded state) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopPart(),
              Expanded(
                child: Center(
                  child: Text(
                    state.shareCode,
                    style: context.typo.extraLargeBold(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.router.pop(true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            BlocProvider.of<ShareGroupCubit>(context)
                .refreshShareCode(widget.groupId);
          },
          icon: const Icon(Icons.refresh),
        )
      ],
    );
  }
}
