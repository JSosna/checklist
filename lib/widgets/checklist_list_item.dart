import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double height;
  final Widget? leading;
  final bool roundedCorners;

  const ChecklistListItem({
    Key? key,
    required this.child,
    required this.onPressed,
    this.height = 55,
    this.leading,
    this.roundedCorners = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius:
          roundedCorners ? BorderRadius.circular(8) : BorderRadius.zero,
      color: context.isDarkTheme
          ? Colors.grey[800]?.withOpacity(0.5)
          : Colors.blueGrey[300]?.withOpacity(0.5),
      child: InkWell(
        borderRadius:
            roundedCorners ? BorderRadius.circular(8) : BorderRadius.zero,
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.marginLarge,
              vertical: Dimens.marginSmall,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: Dimens.marginMedium)
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
