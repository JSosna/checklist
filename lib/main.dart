import 'dart:async';

import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:checklist/data/theme/theme_mode.dart' as checklist_theme_mode;
import 'package:checklist/injection/bloc_factory.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/injection/modules.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  final GetIt injector = GetIt.instance;
  await registerModules(injector);
  
  final AppInitializer initializer = injector.get();
  await initializer.init();

  runZonedGuarded(() {
    runApp(MultiProvider(
      providers: [
        Provider<BlocFactory>(
            create: (context) => BlocFactory(injector: injector)),
        Provider<CubitFactory>(
            create: (context) => CubitFactory(injector: injector)),
      ],
      child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en"), Locale("pl")],
          fallbackLocale: const Locale("en"),
          child: App()),
    ));
  }, (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
  });
}

class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final ThemeCubit themeCubit = cubitFactory.get();

    return BlocProvider(
      create: (context) => themeCubit,
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
              state.theme == checklist_theme_mode.ThemeMode.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark);
        },
        builder: (context, state) {
          return MaterialApp.router(
            theme: state.theme == checklist_theme_mode.ThemeMode.dark
                ? themeDark
                : themeLight,
            debugShowCheckedModeBanner: false,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
