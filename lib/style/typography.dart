import 'package:flutter/material.dart';

class AppTypography {
  TextStyle medium({Color? color = Colors.black}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle mediumBold({Color? color = Colors.black}) {
    return TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle large({Color? color = Colors.black}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle largeBold({Color? color = Colors.black}) {
    return TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle small({Color? color = Colors.black}) {
    return TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle smallBold({Color? color = Colors.black}) {
    return TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: color);
  }
}
