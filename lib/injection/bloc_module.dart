import 'package:checklist/domain/theme/theme_storage.dart';
import 'package:checklist/presentation/authentication/login/cubit/login_cubit.dart';
import 'package:checklist/presentation/authentication/register/cubit/register_cubit.dart';
import 'package:checklist/presentation/checklists/add/cubit/add_checklist_cubit.dart';
import 'package:checklist/presentation/checklists/details/cubit/checklist_details_cubit.dart';
import 'package:checklist/presentation/checklists/list/cubit/checklists_cubit.dart';
import 'package:checklist/presentation/groups/add/cubit/add_group_cubit.dart';
import 'package:checklist/presentation/groups/details/cubit/group_details_cubit.dart';
import 'package:checklist/presentation/groups/list/cubit/groups_cubit.dart';
import 'package:checklist/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:checklist/presentation/settings/cubit/settings_cubit.dart';
import 'package:checklist/presentation/splash/bloc/splash_bloc.dart';
import 'package:checklist/presentation/tab/cubit/authentication_cubit.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> registerBlocModule(GetIt injector) async {
  final initialTheme = await injector.get<ThemeStorage>().loadThemeMode();

  injector.registerFactory(() => ThemeCubit(initialTheme, injector.get()));
  injector.registerFactory(() => AuthenticationCubit(injector.get()));
  injector.registerFactory(() => SplashBloc(injector.get(), injector.get()));
  injector.registerFactory(() => LoginCubit(injector.get(), injector.get()));
  injector.registerFactory(() => RegisterCubit(injector.get()));
  injector.registerFactory(() => OnboardingCubit());
  injector.registerFactory(() => ChecklistsCubit(injector.get()));
  injector.registerFactory(() => ChecklistDetailsCubit(injector.get()));
  injector.registerFactory(() => GroupsCubit(injector.get()));
  injector.registerFactory(() => GroupDetailsCubit(injector.get(), injector.get(), injector.get(), injector.get()));
  injector.registerFactory(() => AddGroupCubit(injector.get(), injector.get()));
  injector.registerFactory(() => AddChecklistCubit(injector.get()));
  injector.registerFactory(() => SettingsCubit(injector.get(), injector.get(), injector.get()));
}
