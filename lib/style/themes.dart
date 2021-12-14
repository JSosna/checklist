import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData.light().copyWith(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.5),
  ),
);

ThemeData themeDark = ThemeData.dark().copyWith(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white.withOpacity(0.5),
  ),
);
