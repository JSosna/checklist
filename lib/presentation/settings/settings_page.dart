import 'package:auto_route/auto_route.dart';
import 'package:checklist/data/theme/theme_mode.dart' as checklist_theme_mode;
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/settings/cubit/settings_cubit.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_settings_text_input.dart';
import 'package:checklist/widgets/checklist_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    final SettingsCubit settingsCubit = cubitFactory.get();

    return BlocProvider<SettingsCubit>(
      create: (context) => settingsCubit,
      child: this,
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsCubit>(context).initializeSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) {
              return current is! SettingsUpdating;
            },
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return _buildContent(context, state);
              } else {
                return _buildLoader();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(child: ChecklistLoadingIndicator());
  }

  Widget _buildContent(BuildContext context, SettingsLoaded state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: Dimens.kMarginLarge),
        ChecklistSettingsTextInput(
          title: translate(LocaleKeys.settings_username),
          value: state.user?.name ?? "",
          onChanged: (newValue) {
            BlocProvider.of<SettingsCubit>(context).changeUsername(newValue);
          },
        ),
        const SizedBox(height: Dimens.kMarginMedium),
        _buildDarkModeSwitch(),
        const SizedBox(height: Dimens.kMarginMedium),
        _buildBiometricAuthenticationSwitch(state),
        const Spacer(),
        ChecklistRoundedButton(
          text: translate(LocaleKeys.settings_logout),
          onPressed: () {
            BlocProvider.of<SettingsCubit>(context).logout();
          },
        )
      ],
    );
  }

  Widget _buildDarkModeSwitch() {
    return ChecklistSwitch(
      value: context.isDarkTheme,
      label: LocaleKeys.settings_dark_mode.tr(),
      onChanged: (value) {
        BlocProvider.of<ThemeCubit>(context).changeThemeMode(
          theme: context.isDarkTheme
              ? checklist_theme_mode.ThemeMode.light
              : checklist_theme_mode.ThemeMode.dark,
        );
      },
    );
  }

  Widget _buildBiometricAuthenticationSwitch(SettingsLoaded state) {
    return ChecklistSwitch(
      label: LocaleKeys.settings_biometric_authentication.tr(),
      value: state.settings.isBiometricsActive,
      onChanged: (value) async {
        await BlocProvider.of<SettingsCubit>(context).toggleBiometricsOption(state.user);
      },
    );
  }
}
