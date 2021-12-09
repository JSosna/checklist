import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';

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
              final element = currentElements.removeAt(oldIndex);
              currentElements.insert(newIndex, element);
              widget.onItemsUpdated(currentElements);
            },
            itemBuilder: (context, index) {
              return ChecklistListItem(
                key: ValueKey(widget.elements[index].index),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChecklistTextField(controller: titleController),
              ChecklistTextField(controller: descriptionController),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                final element = ChecklistElement(
                  index: 0,
                  name: titleController.text,
                  description: descriptionController.text,
                );

                currentElements.insert(0, element);

                onItemsUpdated(currentElements);
                context.router.pop();
              },
            )
          ],
        );
      },
    );
  }
}
