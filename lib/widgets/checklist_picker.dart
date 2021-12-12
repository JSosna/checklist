import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistPicker extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ChecklistPicker({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.withOpacity(0.5),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.kMarginLarge),
          child: Row(
            children: [Expanded(child: Text(text)), const Icon(Icons.search)],
          ),
        ),
      ),
    );
  }
}
