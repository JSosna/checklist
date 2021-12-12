import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer extends AppInitializer {
  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
