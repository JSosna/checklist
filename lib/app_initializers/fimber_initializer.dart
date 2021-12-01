import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:checklist/utlis/crash_reporting_tree.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

class FimberInitializer extends AppInitializer {
  @override
  Future<void> init() async {
    if (kDebugMode) {
      Fimber.plantTree(DebugTree());
    } else {
      Fimber.plantTree(CrashReportingTree());
    }
  }
}
