import 'package:checklist/presentation/authorization/splash/splash_page.dart';
import 'package:checklist/presentation/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SplashPage());
  }
}
