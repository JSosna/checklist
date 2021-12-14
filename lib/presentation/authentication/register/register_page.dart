import 'package:auto_route/auto_route.dart';
import 'package:checklist/domain/authentication/authentication_error_type.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/authentication/register/cubit/register_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_large_text_button.dart';
import 'package:checklist/widgets/checklist_page_title.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_scrollable_wrapper.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    return BlocProvider<RegisterCubit>(
      create: (context) => cubitFactory.get<RegisterCubit>(),
      child: this,
    );
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailValidator = MultiValidator([
    RequiredValidator(
      errorText: translate(LocaleKeys.validation_email_is_required),
    ),
    EmailValidator(
      errorText: translate(LocaleKeys.validation_email_is_invalid),
    ),
    MaxLengthValidator(30, errorText: "Too long"),
  ]);

  final _usernameValidator = MultiValidator([
    RequiredValidator(
      errorText: translate(LocaleKeys.validation_username_is_required),
    ),
    MinLengthValidator(
      4,
      errorText: translate(LocaleKeys.validation_username_too_short),
    ),
    MaxLengthValidator(20, errorText: "Too long"),
  ]);

  final _passwordValidator = MultiValidator([
    RequiredValidator(
      errorText: translate(LocaleKeys.validation_password_is_required),
    ),
    MinLengthValidator(
      4,
      errorText: translate(LocaleKeys.validation_password_too_short),
    ),
    MaxLengthValidator(20, errorText: "Too long"),
    PatternValidator(
      r'(?=.*?[#?!@$%^&*-])',
      errorText: translate(LocaleKeys.validation_password_special),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.router.replace(const OnboardingRoute());
        } else if (state is RegisterError) {
          final message = _mapLoginError(state.authenticationError);
          Fluttertoast.showToast(
            msg: message,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return ChecklistBlurredBackgroundWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.marginExtraLargeDouble,
                  ),
                  child: ChecklistScrollableWrapper(
                    child: Column(
                      children: [
                        const SizedBox(height: Dimens.marginLarge),
                        ChecklistPageTitle(
                          translate(LocaleKeys.authentication_register),
                        ),
                        const SizedBox(height: Dimens.marginLargeDouble),
                        ..._buildForm(),
                        const Spacer(),
                        _buildRegisterButton(state),
                        const SizedBox(height: Dimens.marginMedium),
                        _buildLoginButton(),
                        const SizedBox(height: Dimens.marginMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildForm() {
    return [
      ChecklistTextFormField(
        controller: _usernameController,
        validator: _usernameValidator,
        label: translate(LocaleKeys.authentication_username),
      ),
      const SizedBox(height: Dimens.marginMedium),
      ChecklistTextFormField(
        controller: _emailController,
        validator: _emailValidator,
        label: translate(LocaleKeys.authentication_email),
        textInputType: TextInputType.emailAddress,
      ),
      const SizedBox(height: Dimens.marginMedium),
      ChecklistTextFormField(
        controller: _passwordController,
        validator: _passwordValidator,
        label: translate(LocaleKeys.authentication_password),
        isObscured: true,
      ),
      const SizedBox(height: Dimens.marginMedium),
      ChecklistTextFormField(
        controller: _confirmPasswordController,
        validator: (val) => MatchValidator(
          errorText: translate(
            LocaleKeys.validation_passwords_do_not_match,
          ),
        ).validateMatch(val ?? "", _passwordController.text),
        label: translate(LocaleKeys.authentication_confirm_password),
        isObscured: true,
        textInputAction: TextInputAction.done,
      ),
    ];
  }

  Widget _buildRegisterButton(RegisterState state) {
    return ChecklistRoundedButton(
      text: translate(LocaleKeys.authentication_register),
      isLoading: state is RegisterLoading,
      onPressed: () async {
        final username = _usernameController.text;
        final email = _emailController.text;
        final password = _passwordController.text;

        if (_formKey.currentState?.validate() == true) {
          BlocProvider.of<RegisterCubit>(context).register(
            username: username,
            email: email,
            password: password,
          );
        }
      },
    );
  }

  Widget _buildLoginButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ChecklistLargeTextButton(
        text: translate(LocaleKeys.authentication_login),
        forward: false,
        onPressed: () async {
          context.router.pop();
        },
      ),
    );
  }

  String _mapLoginError(AuthenticationErrorType authenticationError) {
    switch (authenticationError) {
      case AuthenticationErrorType.invalidEmail:
        return translate(LocaleKeys.authentication_errors_invalid_email);
      case AuthenticationErrorType.emailAlreadyInUse:
        return translate(LocaleKeys.authentication_errors_email_already_in_use);
      case AuthenticationErrorType.weakPassword:
        return translate(LocaleKeys.authentication_errors_weak_password);
      default:
        return translate(LocaleKeys.authentication_errors_unknown_error);
    }
  }
}
