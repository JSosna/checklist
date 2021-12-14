import 'dart:async';

import 'package:checklist/app_initializers/app_initializer.dart';
import 'package:checklist/checklist_app.dart';

import 'package:checklist/injection/bloc_factory.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/injection/modules.dart';
import 'package:checklist/utlis/color_generator.dart';
import 'package:checklist/widgets/blurred_background_state_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final GetIt injector = GetIt.instance;
  await registerModules(injector);

  final AppInitializer initializer = injector.get();
  await initializer.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          Provider<BlocFactory>(
            create: (context) => BlocFactory(injector: injector),
          ),
          Provider<CubitFactory>(
            create: (context) => CubitFactory(injector: injector),
          ),
          Provider<ColorGenerator>(
            create: (context) => ColorGenerator(),
          ),
          Provider<BlurredBackgroundStateProvider>(
            create: (context) => BlurredBackgroundStateProvider(),
          ),
        ],
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en"), Locale("pl")],
          fallbackLocale: const Locale("en"),
          child: ChecklistApp(),
        ),
      ),
    );
  }, (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
  });
}
