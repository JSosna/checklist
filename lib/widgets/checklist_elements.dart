import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChecklistElements extends StatefulWidget {
  final List<ChecklistElement> elements;
  final void Function(List<ChecklistElement>) onItemsUpdated;

  const ChecklistElements({
    required this.elements,
    required this.onItemsUpdated,
  });

  @override
  _ChecklistElementsState createState() => _ChecklistElementsState();
}

class _ChecklistElementsState extends State<ChecklistElements> {
  late List<ChecklistElement> currentElements;
  final _formKey = GlobalKey<FormState>();

  final _titleValidator = MultiValidator([
    MaxLengthValidator(100, errorText: "error"),
    RequiredValidator(
      errorText: "error",
    ),
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
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              _showNewElementModal();
            },
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
            splashRadius: 20.0,
          ),
        ),
        Expanded(
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
            itemBuilder: (context, index) {
              return ChecklistListItem(
                key: ValueKey(currentElements[index].name),
                element: currentElements[index],
                onPressed: () {
                  _showNewElementModal(index, currentElements[index]);
                },
                onDismissed: () {
                  setState(() {
                    currentElements.removeAt(index);
                    widget.onItemsUpdated(currentElements);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showNewElementModal([int? index, ChecklistElement? existingElement]) {
    final titleController = TextEditingController(text: existingElement?.name);
    final descriptionController =
        TextEditingController(text: existingElement?.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: index != null
              ? const Text("Edit item")
              : const Text("Add new item"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChecklistTextField(
                  controller: titleController,
                  validator: _titleValidator,
                ),
                ChecklistTextField(controller: descriptionController),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                if (_formKey.currentState?.validate() == false) {
                  return;
                }

                final title = titleController.text;

                if (index == null &&
                    widget.elements.any((element) => element.name == title)) {
                  // TODO: Show toast - "Item with this name already exists"
                  return;
                }

                if (index != null && existingElement != null) {
                  final element = existingElement.copyWith(
                    name: titleController.text,
                    description: descriptionController.text,
                  );

                  currentElements[index] = element;
                } else {
                  final element = ChecklistElement(
                    index: 0,
                    name: titleController.text,
                    description: descriptionController.text,
                  );

                  currentElements.insert(0, element);
                }

                setState(() {
                  widget.onItemsUpdated(currentElements);
                });
                context.router.pop();
              },
            )
          ],
        );
      },
    );
  }
}
