import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/authorization/splash/splash_page.dart';
import 'package:checklist/presentation/home/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}
