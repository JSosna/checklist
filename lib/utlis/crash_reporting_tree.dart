import 'package:fimber/fimber.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashReportingTree extends LogTree {
  static const List<String> defaultLevels = ["W", "E"];

  @override
  List<String> getLevels() => defaultLevels;

  @override
  void log(String level, String message,
      {String? tag, dynamic ex, StackTrace? stacktrace}) {
    final crashlytics = FirebaseCrashlytics.instance;
    crashlytics.log(message);

    if (ex != null && stacktrace != null) {
      crashlytics.recordError(ex, stacktrace);
    }
  }
}
