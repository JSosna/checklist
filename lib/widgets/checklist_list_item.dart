import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double height;

  const ChecklistListItem({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: context.isDarkTheme
          ? Colors.grey[850]?.withOpacity(0.5)
          : Colors.blueGrey[200]?.withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.marginLarge,
              vertical: Dimens.marginSmall,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
