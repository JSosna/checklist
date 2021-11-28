import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextExtensions on BuildContext {
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
