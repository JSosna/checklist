import 'package:auto_route/auto_route.dart';
import 'package:checklist/presentation/authentication/login/login_page.dart';
import 'package:checklist/presentation/authentication/register/register_page.dart';
import 'package:checklist/presentation/groups/list/groups_page.dart';
import 'package:checklist/presentation/home/home_page.dart';
import 'package:checklist/presentation/onboarding/onboarding_page.dart';
import 'package:checklist/presentation/settings/settings_page.dart';
import 'package:checklist/presentation/splash/splash_page.dart';
import 'package:checklist/presentation/tab/tab_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute(
      page: TabPage,
      children: [
        AutoRoute(page: HomePage, initial: true),
        AutoRoute(page: GroupsPage),
        AutoRoute(page: SettingsPage),
      ],
    )
  ],
)
class $AppRouter {}
