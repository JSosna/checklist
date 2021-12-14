import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistLargeTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? forward;

  const ChecklistLargeTextButton({
    required this.text,
    required this.onPressed,
    this.forward,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.marginExtraLarge),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.marginSmall),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (forward == false) ...[
                const SizedBox(width: Dimens.marginSmall),
                Icon(
                  Icons.arrow_back_rounded,
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
              ],
              FittedBox(
                alignment: Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: context.typo.mediumBold(
                    color: context.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              if (forward == true) ...[
                const SizedBox(width: Dimens.marginSmall),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
