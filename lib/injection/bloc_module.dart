import 'package:checklist/presentation/authorization/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';

void registerBlocModule(GetIt injector) {
  injector.registerFactory(() => SplashCubit());
}
