import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsInitializer extends AppInitializer {
  @override
  Future<void> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
