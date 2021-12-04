import 'package:checklist/data/authentication/firebase_authentication_repository.dart';
import 'package:checklist/data/settings/hive_settings_storage.dart';
import 'package:checklist/data/theme/hive_theme_storage.dart';
import 'package:checklist/domain/authentication/authentication_repository.dart';
import 'package:checklist/domain/settings/settings_storage.dart';
import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:checklist/injection/hive_initializer.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

void registerRepositoryModule(GetIt injector) {
  injector.registerFactory<ThemeStorage>(() => HiveThemeStorage(injector.get(instanceName: THEME_BOX)));
  injector.registerFactory<SettingsStorage>(() => HiveSettingsStorage(injector.get(instanceName: SETTINGS_BOX)));

  final LocalAuthentication localAuthentication = LocalAuthentication();
  injector.registerFactory<AuthenticationRepository>(() => FirebaseAuthenticationRepository(localAuthentication));
}
