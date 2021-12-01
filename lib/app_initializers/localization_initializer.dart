import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationInitializer extends AppInitializer {
  @override
  Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }
}
