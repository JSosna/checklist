import 'package:checklist/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextExtensions on BuildContext {
  AppTypography get typo => AppTypography();
  
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
