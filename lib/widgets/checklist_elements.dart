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
              _showNewElementModal(widget.onItemsUpdated);
            },
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
            splashRadius: 20.0,
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: widget.elements.length,
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
                key: ValueKey(widget.elements[index].name),
                element: widget.elements[index],
              );
            },
          ),
        ),
      ],
    );
  }

  void _showNewElementModal(
    void Function(List<ChecklistElement>) onItemsUpdated,
  ) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new item"),
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

                if (widget.elements.any((element) => element.name == title)) {
                  // TODO: Show toast - "Item with this name already exists"
                  return;
                }

                final element = ChecklistElement(
                  index: 0,
                  name: titleController.text,
                  description: descriptionController.text,
                );

                setState(() {
                  currentElements.insert(0, element);

                  onItemsUpdated(currentElements);
                  context.router.pop();
                });
              },
            )
          ],
        );
      },
    );
  }
}
