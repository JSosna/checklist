import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistEmptyListView extends StatelessWidget {
  final String? hint;

  const ChecklistEmptyListView({Key? key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Nothing to show...",
          style: context.typo.largeBold(
            color: context.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        if (hint?.isNotEmpty == true) ...[
          const SizedBox(height: Dimens.marginMedium),
          Text(
            hint ?? "",
            style: context.typo.mediumBold(
              color: context.isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
        ]
      ],
    );
  }
}
