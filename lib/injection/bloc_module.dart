import 'package:checklist/presentation/home/cubit/home_cubit.dart';
import 'package:checklist/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:checklist/presentation/settings/cubit/settings_cubit.dart';
import 'package:checklist/presentation/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';

void registerBlocModule(GetIt injector) {
  injector.registerFactory(() => SplashCubit());
  injector.registerFactory(() => OnboardingCubit());
  injector.registerFactory(() => HomeCubit());
  injector.registerFactory(() => SettingsCubit());
}
