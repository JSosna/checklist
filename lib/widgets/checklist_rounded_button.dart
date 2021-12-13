import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const ChecklistRoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.marginLargeDouble,
        vertical: Dimens.marginLarge,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size?>(
            const Size(double.infinity, 60.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: context.typo.medium(color: Colors.white),
        ),
      ),
    );
  }
}
