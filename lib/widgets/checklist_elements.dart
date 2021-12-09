import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:flutter/material.dart';

class ChecklistElements extends StatefulWidget {
  final List<ChecklistElement> elements;

  const ChecklistElements({required this.elements});

  @override
  _ChecklistElementsState createState() => _ChecklistElementsState();
}

class _ChecklistElementsState extends State<ChecklistElements> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.elements.length,
      itemBuilder: (context, index) {
        return ChecklistListItem(element: widget.elements[index]);
      },
    );
  }
}
