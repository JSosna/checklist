import 'package:checklist/domain/theme/theme_mode.dart' as checklist_theme_mode;
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:checklist/widgets/checklist_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ChecklistSwitch(
                label: "dark mode",
                value: context.isDarkTheme,
                onChanged: (value) {
                  BlocProvider.of<ThemeCubit>(context).changeThemeMode(
                      theme: context.isDarkTheme
                          ? checklist_theme_mode.ThemeMode.light
                          : checklist_theme_mode.ThemeMode.dark);
                })));
  }
}
