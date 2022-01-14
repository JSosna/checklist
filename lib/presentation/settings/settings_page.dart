import 'package:auto_route/auto_route.dart';
import 'package:checklist/data/theme/theme_mode.dart' as checklist_theme_mode;
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/settings/cubit/settings_cubit.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_dialog.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_page_title.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_settings_text_input.dart';
import 'package:checklist/widgets/checklist_switch.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(
      errorText: LocaleKeys.validation_this_field_is_required.tr(),
    ),
    MaxLengthValidator(30, errorText: LocaleKeys.validation_too_long.tr()),
  ]);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsCubit>(context).initializeSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: BlocConsumer<SettingsCubit, SettingsState>(
              listener: (context, state) {
                if (state is AccountDeleteFailed) {
                  Fluttertoast.showToast(
                    msg: LocaleKeys.authentication_errors_account_delete_failed
                        .tr(),
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.red,
                  );
                }
              },
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
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(child: ChecklistLoadingIndicator());
  }

  Widget _buildContent(BuildContext context, SettingsLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.marginLargeDouble),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: Dimens.marginLarge),
          ChecklistPageTitle(LocaleKeys.tab_settings.tr()),
          const SizedBox(height: Dimens.marginMedium),
          ChecklistSettingsTextInput(
            title: translate(LocaleKeys.settings_username),
            value: state.user?.name ?? "",
            validator: MultiValidator([
              RequiredValidator(
                errorText: LocaleKeys.validation_this_field_is_required.tr(),
              ),
              MaxLengthValidator(
                21,
                errorText: LocaleKeys.validation_too_long.tr(),
              )
            ]),
            onChanged: (newValue) {
              BlocProvider.of<SettingsCubit>(context).changeUsername(newValue);
            },
          ),
          const SizedBox(height: Dimens.marginMedium),
          _buildDarkModeSwitch(),
          const SizedBox(height: Dimens.marginMedium),
          _buildBiometricAuthenticationSwitch(state),
          const Spacer(),
          ChecklistRoundedButton(
            text: translate(LocaleKeys.settings_logout),
            onPressed: () {
              BlocProvider.of<SettingsCubit>(context).logout();
            },
          ),
          const SizedBox(height: Dimens.marginMedium),
          ChecklistRoundedButton.negative(
            text: LocaleKeys.settings_delete_account.tr(),
            onPressed: () async {
              final password = await _openPasswordDialog();

              if (password != null) {
                if (!mounted) return;
                BlocProvider.of<SettingsCubit>(context).deleteAccount(password);
              }
            },
          ),
          const SizedBox(height: Dimens.marginLarge),
        ],
      ),
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
        await BlocProvider.of<SettingsCubit>(context)
            .toggleBiometricsOption(state.user);
      },
    );
  }

  Future<String?> _openPasswordDialog() async {
    return showDialog<String?>(
      context: context,
      builder: (context) => ChecklistDialog(
        title: LocaleKeys.editable_label_edit_label.tr(),
        children: [
          Form(
            key: _formKey,
            child: ChecklistTextField(
              autofocus: true,
              controller: _controller,
              validator: passwordValidator,
            ),
          ),
        ],
        onSubmit: () {
          final password = _controller.text;

          if (_formKey.currentState?.validate() == true) {
            Navigator.of(context).pop(password);
          }
        },
      ),
    );
  }
}
