import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/add/cubit/add_group_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final AddGroupCubit addGroupCubit = cubitFactory.get();

    return BlocProvider<AddGroupCubit>(
      create: (context) => addGroupCubit,
      child: this,
    );
  }

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  TextEditingController? joinGroupController;

  @override
  void initState() {
    super.initState();
    joinGroupController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupCubit, AddGroupState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(),
                _buildJoinGroupPart(),
                const Divider(height: Dimens.kMarginExtraLargeDouble),
                Expanded(child: _buildCreateGroupPart()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      onPressed: () {
        context.router.pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _buildJoinGroupPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Join existing group"),
        Row(
          children: [
            Expanded(child: TextField(controller: joinGroupController)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildCreateGroupPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Create new group"),
        const SizedBox(height: Dimens.kMarginExtraLargeDouble),
        const Text("Name"),
        TextField(controller: joinGroupController),
        const Spacer(),
        ChecklistRoundedButton(text: "Create", onPressed: () {}),
      ],
    );
  }
}
