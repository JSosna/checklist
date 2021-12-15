import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/checklists/add/cubit/add_checklist_cubit.dart';
import 'package:checklist/presentation/checklists/list/checklists_loader_cubit/cubit/checklists_loader_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_picker.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChecklistPage extends StatefulWidget implements AutoRouteWrapper {
  final Group? initialGroup;

  const AddChecklistPage({
    this.initialGroup,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final AddChecklistCubit addChecklistCubit = cubitFactory.get();

    return BlocProvider<AddChecklistCubit>(
      create: (context) => addChecklistCubit,
      child: this,
    );
  }

  @override
  _AddChecklistPageState createState() => _AddChecklistPageState();
}

class _AddChecklistPageState extends State<AddChecklistPage> {
  late final TextEditingController _nameController;
  Group? _group;
  bool checkable = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _group = widget.initialGroup;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddChecklistCubit, AddChecklistState>(
      listener: (context, state) {
        if (state is CreatedNewChecklist) {
          BlocProvider.of<ChecklistsLoaderCubit>(context).reloadChecklists();
          context.router.pop(true);
        } else if (state is ErrorWhileCreatingChecklist) {
          // TODO: show error toast
        }
      },
      builder: (context, state) {
        return ChecklistBlurredBackgroundWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(),
                  Expanded(child: _buildContent()),
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
      padding: const EdgeInsets.symmetric(horizontal: Dimens.marginExtraLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Create new checklist"),
          const SizedBox(height: Dimens.marginExtraLargeDouble),
          const Text("Group"),
          ChecklistPicker(
            text: _group?.name ?? "",
            onPressed: () async {
              final result = await context.router.push(const GroupPickerRoute());

              if (result is Group) {
                setState(() {
                  _group = result;
                });
              }
            },
          ),
          const SizedBox(height: Dimens.marginExtraLargeDouble),
          const Text("Name"),
          ChecklistTextFormField(controller: _nameController),
          const SizedBox(height: Dimens.marginExtraLargeDouble),
          const Text("Checkable"),
          Checkbox(
            value: checkable,
            onChanged: (checked) {
              setState(() {
                checkable = checked ?? false;
              });
            },
          ),
          const Spacer(),
          ChecklistRoundedButton(
            text: "Create",
            onPressed: () {
              // TODO: Use text form validator
              final name = _nameController.text.trim();
              final groupId = _group?.id;

              if (name.length > 4 && groupId != null) {
                BlocProvider.of<AddChecklistCubit>(context)
                    .createNewChecklist(groupId, name, checkable: checkable);
              }
            },
          ),
          const SizedBox(height: Dimens.marginLarge),
        ],
      ),
    );
  }
}
