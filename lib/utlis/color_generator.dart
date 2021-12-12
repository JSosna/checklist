import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  Color generateColor(String seed) {
    int intSeed = 0;

    for (var i = 0; i < seed.length; i++) {
      intSeed += seed.codeUnitAt(i);
    }

    final random = Random(intSeed);

    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
