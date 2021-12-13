import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/colors.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? splashColor;

  const ChecklistRoundedButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.splashColor,
  });

  const ChecklistRoundedButton.negative({
    required this.text,
    required this.onPressed,
    this.color = AppColors.red,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.0,
      child: Material(
        color: color ?? (context.isDarkTheme ? Colors.white : Colors.black),
        borderRadius: BorderRadius.circular(60.0),
        child: InkWell(
          splashColor: splashColor ??
              (context.isDarkTheme ? Colors.black : Colors.white),
          borderRadius: BorderRadius.circular(60.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.marginLarge),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: context.typo.mediumBold(
                color: context.isDarkTheme ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
