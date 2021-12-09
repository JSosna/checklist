import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:flutter/material.dart';

class ChecklistElements extends StatefulWidget {
  final List<ChecklistElement> elements;
  final void Function(List<ChecklistElement>) onReorder;

  const ChecklistElements({required this.elements, required this.onReorder});

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
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          padding: EdgeInsets.zero,
          splashRadius: 20.0,
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: widget.elements.length,
            onReorder: (oldIndex, newIndex) {
              final element = currentElements.removeAt(oldIndex);
              currentElements.insert(newIndex, element);
              widget.onReorder(currentElements);
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
}
