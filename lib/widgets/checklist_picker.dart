import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistPicker extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? label;

  const ChecklistPicker({required this.text, required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: Dimens.marginMedium),
            child: Text(
              label ?? "",
              style: context.typo.mediumBold(
                color: context.isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: Dimens.marginSmall),
        ],
        _buildPickerContent(context),
      ],
    );
  }

  Widget _buildPickerContent(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      color: context.isDarkTheme
          ? Colors.grey[850]?.withOpacity(0.5)
          : Colors.blueGrey[200]?.withOpacity(0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: Dimens.marginLarge,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: context.typo.medium(
                    color: context.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.search)
            ],
          ),
        ),
      ),
    );
  }
}
