import 'package:checklist/domain/checklists/checklist.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final Checklist checklist;
  final VoidCallback onPressed;

  const ChecklistListItem({required this.checklist, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(checklist.name ?? ""),
      onTap: onPressed,
    );
  }
}
