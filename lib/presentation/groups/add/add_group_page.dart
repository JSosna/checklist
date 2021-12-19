import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(),
                  Expanded(
                    child: _buildContent(),
                  ),
                ],
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

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.marginLargeDouble,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJoinGroupPart(),
          const Divider(
            height: Dimens.marginExtraLargeDouble,
            thickness: 2.0,
          ),
          Expanded(child: _buildCreateGroupPart()),
          const SizedBox(height: Dimens.marginLarge),
        ],
      ),
    );
  }

  Widget _buildJoinGroupPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Join existing group",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: Dimens.marginLargeDouble),
        Row(
          children: [
            Expanded(
              child: ChecklistTextField(
                label: "Share code",
                controller: joinGroupController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.marginSmall),
              child: IconButton(
                onPressed: () {
                  final shareCode = joinGroupController.text.trim();

                  // TODO: Use text form validator
                  if (shareCode.length == 6) {
                    BlocProvider.of<AddGroupCubit>(context)
                        .joinToExistingGroup(shareCode);
                  }
                },
                icon: const Icon(Icons.arrow_forward),
              ),
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
        Text(
          "Create new group",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: Dimens.marginLargeDouble),
        ChecklistTextField(
          label: "Name",
          controller: newGroupNameController,
        ),
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
