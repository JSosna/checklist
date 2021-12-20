import 'package:checklist/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ChecklistDialogMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const ChecklistDialogMenuItem({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
      child: ListTile(
        title: Text(
          text,
          style: context.typo.mediumBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        enabled: enabled,
      ),
    );
  }
}
