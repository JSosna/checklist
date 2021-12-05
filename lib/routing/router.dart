import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/authentication/login/login_page.dart';
import 'package:checklist/presentation/authentication/register/register_page.dart';
import 'package:checklist/presentation/onboarding/onboarding_page.dart';
import 'package:checklist/presentation/splash/splash_page.dart';
import 'package:checklist/presentation/tab/tab_page.dart';
import 'package:checklist/routing/tabs_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute<dynamic>(
      page: TabPage,
      name: 'TabRouter',
      children: TabsRoutes.items,
    ),
  ],
)
class $AppRouter {}
