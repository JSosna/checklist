import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/add/cubit/add_group_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
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
  late final TextEditingController joinGroupController;
  late final TextEditingController newGroupNameController;

  @override
  void initState() {
    super.initState();
    joinGroupController = TextEditingController();
    newGroupNameController = TextEditingController();
  }

  @override
  void dispose() {
    joinGroupController.dispose();
    newGroupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddGroupCubit, AddGroupState>(
      listener: (context, state) {
        if (state is AddedUserToGroup) {
          context.router.pop(true);
        } else if (state is ErrorWhileAddingUserToGroup) {
          // TODO: show error toast (maybe abstract class joinResult with - Joined, AlreadyIn, Expired, Error)
        } else if (state is CreatedNewGroup) {
          context.router.pop(true);
        } else if (state is ErrorWhileCreatingGroup) {
          // TODO: show error toast
        }
      },
      builder: (context, state) {
        return ChecklistBlurredBackgroundWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.marginLargeDouble,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBackButton(),
                    _buildJoinGroupPart(),
                    const Divider(height: Dimens.marginExtraLargeDouble),
                    Expanded(child: _buildCreateGroupPart()),
                    const SizedBox(height: Dimens.marginLarge),
                  ],
                ),
              ),
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
            Expanded(
              child: ChecklistTextFormField(controller: joinGroupController),
            ),
            IconButton(
              onPressed: () {
                final shareCode = joinGroupController.text.trim();

                // TODO: Use text form validator
                if (shareCode.length == 6) {
                  BlocProvider.of<AddGroupCubit>(context)
                      .joinToExistingGroup(shareCode);
                }
              },
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
        const SizedBox(height: Dimens.marginExtraLargeDouble),
        const Text("Name"),
        ChecklistTextFormField(controller: newGroupNameController),
        const Spacer(),
        ChecklistRoundedButton(
          text: "Create",
          onPressed: () {
            // TODO: Use text form validator
            final name = newGroupNameController.text.trim();

            if (name.length > 4) {
              BlocProvider.of<AddGroupCubit>(context).createNewGroup(name);
            }
          },
        ),
      ],
    );
  }
}
