import 'package:checklist/injection/bloc_factory.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/injection/hive_initializer.dart';
import 'package:checklist/injection/modules.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  Fimber.plantTree(DebugTree());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final GetIt injector = GetIt.instance;
  await setupHive();
  registerModules(injector);

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
}

class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
