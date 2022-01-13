import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/presentation/checklists/details/widgets/checklist_dismissible_list_item.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_dialog.dart';
import 'package:checklist/widgets/checklist_empty_list_view.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChecklistElements extends StatefulWidget {
  final List<ChecklistElement> elements;
  final void Function(List<ChecklistElement>) onItemsUpdated;
  final bool checkable;

  const ChecklistElements({
    required this.elements,
    required this.onItemsUpdated,
    this.checkable = false,
  });

  @override
  _ChecklistElementsState createState() => _ChecklistElementsState();
}

class _ChecklistElementsState extends State<ChecklistElements> {
  late List<ChecklistElement> currentElements;
  final _formKey = GlobalKey<FormState>();

  final _titleValidator = MultiValidator([
    RequiredValidator(
      errorText: LocaleKeys.validation_this_field_is_required.tr(),
    ),
    MaxLengthValidator(100, errorText: LocaleKeys.validation_too_long.tr()),
  ]);

  @override
  void initState() {
    super.initState();
    currentElements = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimens.marginSmall),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              _showElementModal();
            },
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
            splashRadius: 20.0,
          ),
        ),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    if (currentElements.isNotEmpty) {
      return _buildList();
    } else {
      return _buildEmptyView();
    }
  }

  Widget _buildEmptyView() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.marginMedium)
              .copyWith(bottom: Dimens.marginExtraLargeDouble * 2),
          child: ChecklistEmptyListView(
            hint: LocaleKeys.checklist_create_new_element.tr(),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ReorderableListView.builder(
        itemCount: currentElements.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            final element = currentElements.removeAt(oldIndex);
            if (oldIndex < newIndex) {
              currentElements.insert(newIndex - 1, element);
            } else {
              currentElements.insert(newIndex, element);
            }

            widget.onItemsUpdated(currentElements);
          });
        },
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ChecklistDismissibleListItem(
      key: ValueKey(currentElements[index].name),
      element: currentElements[index],
      onPressed: () {
        _showElementModal(index, currentElements[index]);
      },
      onDismissed: () {
        setState(() {
          currentElements.removeAt(index);
          widget.onItemsUpdated(currentElements);
        });
      },
      checkable: widget.checkable,
      checked: currentElements[index].checked,
      onCheckedChanged: (checked) {
        setState(() {
          currentElements[index] =
              currentElements[index].copyWith(checked: checked);
          widget.onItemsUpdated(currentElements);
        });
      },
    );
  }

  void _showElementModal([int? index, ChecklistElement? existingElement]) {
    final titleController = TextEditingController(text: existingElement?.name);
    final descriptionController =
        TextEditingController(text: existingElement?.description);

    showDialog(
      context: context,
      builder: (context) => Form(
        key: _formKey,
        child: ChecklistDialog(
          title: index != null ? LocaleKeys.checklist_edit_item.tr() : LocaleKeys.checklist_add_new_item.tr(),
          children: [
            ChecklistTextField(
              controller: titleController,
              validator: _titleValidator,
            ),
            const SizedBox(height: Dimens.marginMedium),
            ChecklistTextField(controller: descriptionController),
          ],
          onSubmit: () {
            _onEditItemSubmit(
              context,
              index,
              existingElement,
              titleController,
              descriptionController,
            );
          },
        ),
      ),
    );
  }

  void _onEditItemSubmit(
    BuildContext context,
    int? index,
    ChecklistElement? existingElement,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final title = titleController.text.trim();

    if (existingElement?.name != title &&
        index != null &&
        widget.elements.any((element) => element.name == title)) {
      Fluttertoast.showToast(
        msg: LocaleKeys.checklist_element_already_exists.tr(),
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    if (index != null && existingElement != null) {
      final element = existingElement.copyWith(
        name: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );

      currentElements[index] = element;
    } else {
      final element = ChecklistElement(
        index: 0,
        name: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );

      currentElements.insert(0, element);
    }

    setState(() {
      widget.onItemsUpdated(currentElements);
    });

    context.router.pop();
  }
}
