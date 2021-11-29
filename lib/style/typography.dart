import 'package:flutter/material.dart';

class AppTypography {
  TextStyle main({Color? color = Colors.black}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle large({Color? color = Colors.black}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle small({Color? color = Colors.black}) {
    return TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: color);
  }
}
