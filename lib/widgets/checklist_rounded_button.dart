import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/colors.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';

class ChecklistRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? splashColor;
  final bool isLoading;

  const ChecklistRoundedButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.splashColor,
    this.isLoading = false,
  });

  const ChecklistRoundedButton.negative({
    required this.text,
    required this.onPressed,
    this.color = AppColors.red,
    this.splashColor,
    this.isLoading = false,
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
          child: isLoading
              ? ChecklistLoadingIndicator(
                  size: 30.0,
                  isDark: context.isDarkTheme,
                )
              : _buildText(context),
        ),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: context.typo.mediumBold(
          color: context.isDarkTheme ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
