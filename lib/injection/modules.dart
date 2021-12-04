import 'package:checklist/injection/bloc_module.dart';
import 'package:checklist/injection/hive_initializer.dart';
import 'package:checklist/injection/initializer_module.dart';
import 'package:checklist/injection/repository_module.dart';
import 'package:checklist/injection/use_case_module.dart';
import 'package:get_it/get_it.dart';

Future<void> registerModules(GetIt injector) async {
  await setupHive(injector);
  registerRepositoryModule(injector);
  registerUseCaseModule(injector);
  await registerBlocModule(injector);
  registerInitializers(injector);
}
