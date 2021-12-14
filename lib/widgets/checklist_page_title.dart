import 'package:checklist/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class ChecklistPageTitle extends StatelessWidget {
  final String text;

  const ChecklistPageTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.typo
          .extraLargeBold(color: context.isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
