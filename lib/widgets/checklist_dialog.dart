import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_large_text_button.dart';
import 'package:flutter/material.dart';

class ChecklistDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onSubmit;

  const ChecklistDialog({
    Key? key,
    required this.title,
    required this.children,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [...children],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimens.marginSmall),
          child: ChecklistLargeTextButton(
            text: translate(LocaleKeys.general_submit),
            forward: true,
            onPressed: onSubmit,
          ),
        ),
      ],
    );
  }
}
