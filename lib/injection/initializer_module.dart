import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:checklist/app_initializers/app_initializer_container.dart';
import 'package:checklist/app_initializers/fimber_initializer.dart';
import 'package:checklist/app_initializers/localization_initializer.dart';
import 'package:get_it/get_it.dart';

void registerInitializers(GetIt injector) {
  injector.registerFactory<LocalizationInitializer>(() => LocalizationInitializer());
  injector.registerFactory<FimberInitializer>(() => FimberInitializer());

  injector.registerFactory<List<AppInitializer>>(() => [
        injector.get<LocalizationInitializer>(),
        injector.get<FimberInitializer>(),
      ],);
      
  injector.registerFactory<AppInitializer>(() => AppInitializerContainer(injector.get()));
}
