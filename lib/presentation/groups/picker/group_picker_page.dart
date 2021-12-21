import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/presentation/groups/picker/cubit/group_picker_cubit.dart';
import 'package:checklist/presentation/groups/picker/group_picker_loader_cubit/group_picker_loader_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPickerPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupPickerCubit>(
          create: (context) =>
              cubitFactory.getGroupPickerCubit(cubitFactory.get()),
        ),
        BlocProvider<GroupPickerLoaderCubit>(
          create: (context) => cubitFactory.get(),
        ),
      ],
      child: this,
    );
  }

  @override
  _GroupPickerPageState createState() => _GroupPickerPageState();
}

class _GroupPickerPageState extends State<GroupPickerPage> {
  late final TextEditingController _groupNameController;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();

    BlocProvider.of<GroupPickerCubit>(context)
        .loadGroups(_groupNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocConsumer<GroupPickerCubit, GroupPickerState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.marginExtraLarge,
                    ),
                    child: ChecklistTextField(
                      controller: _groupNameController,
                      onChanged: (text) {
                        BlocProvider.of<GroupPickerLoaderCubit>(context)
                            .reloadGroups(text);
                      },
                    ),
                  ),
                  Expanded(child: _buildContent(state)),
                ],
              );
            },
          ),
        ),
      ),
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

  Widget _buildContent(GroupPickerState state) {
    if (state is GroupPickerLoading) {
      return const Center(child: ChecklistLoadingIndicator());
    } else if (state is GroupPickerLoaded) {
      return _buildList(state);
    } else {
      return _buildError();
    }
  }

  Widget _buildList(GroupPickerLoaded state) {
    return Stack(
      children: [
        RefreshIndicator(
          color: context.isDarkTheme ? Colors.white : Colors.black,
          onRefresh: () async {
            BlocProvider.of<GroupPickerLoaderCubit>(context)
                .reloadGroups(_groupNameController.text);
          },
          child: ListView.builder(
            itemCount: state.groups.length,
            itemBuilder: (context, index) {
              final groupName = state.groups[index].name;

              if (groupName != null) {
                return ListTile(
                  title: Text(groupName),
                  onTap: () {
                    context.router.pop(state.groups[index]);
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        Center(
          child: BlocBuilder<GroupPickerLoaderCubit, GroupPickerLoaderState>(
            builder: (context, state) {
              if (state is GroupPickerLoaderLoading) {
                return const ChecklistLoadingIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text("Error loading groups"),
    );
  }
}
