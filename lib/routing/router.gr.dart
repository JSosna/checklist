// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../presentation/authentication/login/login_page.dart' as _i3;
import '../presentation/home/home_page.dart' as _i5;
import '../presentation/onboarding/onboarding_page.dart' as _i2;
import '../presentation/settings/settings_page.dart' as _i6;
import '../presentation/splash/splash_page.dart' as _i1;
import '../presentation/tab/tab_page.dart' as _i4;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashPage());
    },
    OnboardingRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.OnboardingPage());
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LoginPage());
    },
    TabRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.TabPage());
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    SettingsRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SettingsPage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashRoute.name, path: '/'),
        _i7.RouteConfig(OnboardingRoute.name, path: '/onboarding-page'),
        _i7.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i7.RouteConfig(TabRoute.name, path: '/tab-page', children: [
          _i7.RouteConfig(HomeRoute.name, path: '', parent: TabRoute.name),
          _i7.RouteConfig(SettingsRoute.name,
              path: 'settings-page', parent: TabRoute.name)
        ])
      ];
}

/// generated route for [_i1.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for [_i2.OnboardingPage]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute() : super(name, path: '/onboarding-page');

  static const String name = 'OnboardingRoute';
}

/// generated route for [_i3.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for [_i4.TabPage]
class TabRoute extends _i7.PageRouteInfo<void> {
  const TabRoute({List<_i7.PageRouteInfo>? children})
      : super(name, path: '/tab-page', initialChildren: children);

  static const String name = 'TabRoute';
}

/// generated route for [_i5.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: 'settings-page');

  static const String name = 'SettingsRoute';
}
