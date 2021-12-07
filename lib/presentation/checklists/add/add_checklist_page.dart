import 'package:auto_route/auto_route.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/checklists/add/cubit/add_checklist_cubit.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChecklistPage extends StatefulWidget implements AutoRouteWrapper {
  final String groupId;

  const AddChecklistPage({required this.groupId});

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
  TextEditingController? _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddChecklistCubit, AddChecklistState>(
      listener: (context, state) {
        if (state is CreatedNewChecklist) {
          BlocProvider.of<ChecklistsCubit>(context).loadChecklists();
          context.router.pop(true);
        } else if (state is ErrorWhileCreatingChecklist) {
          // TODO: show error toast
        }
      },
      builder: (context, state) {
        return Scaffold(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Create new checklist"),
        const SizedBox(height: Dimens.kMarginExtraLargeDouble),
        const Text("Name"),
        TextField(controller: _nameController),
        const Spacer(),
        ChecklistRoundedButton(
          text: "Create",
          onPressed: () {
            // TODO: Use text form validator
            final name = _nameController?.text;

            if (name != null && name.length > 4) {
              BlocProvider.of<AddChecklistCubit>(context)
                  .createNewChecklist(widget.groupId, name);
            }
          },
        ),
      ],
    );
  }
}
