import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:checklist/data/theme/theme_mode.dart' as checkbox_theme_mode;
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/injection/cubit_factory.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:checklist/presentation/theme_cubit/theme_cubit.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_large_text_button.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_switch.dart';
import 'package:checklist/widgets/vertical_page_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatefulWidget implements AutoRouteWrapper {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    final CubitFactory cubitFactory = CubitFactory.of(context);
    return BlocProvider<OnboardingCubit>(
      create: (context) => cubitFactory.get<OnboardingCubit>(),
      child: this,
    );
  }

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();

  late AnimationController _animationController;

  bool reachedLastPage = false;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<OnboardingCubit>(context).initializeSettings();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              _buildPageView(),
              VerticalPageIndicators(
                controller: _pageController,
                indicatorsCount: 3,
              ),
              _buildControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          if (page == 2) {
            reachedLastPage = true;
            _animationController.reverse();
          } else {
            reachedLastPage = false;
            _animationController.forward();
          }
        });
      },
      children: [
        _buildFirstPage(),
        _buildSecondPage(),
        _buildThirdPage(),
      ],
    );
  }

  Widget _buildFirstPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            translate(LocaleKeys.onboarding_lists),
            style: context.typo.largeBold(
              color: context.isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: Dimens.marginExtraLargeDouble),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: Dimens.marginMedium),
              Text(
                translate(LocaleKeys.onboarding_create),
                style: context.typo.medium(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: Dimens.marginMedium),
              SizedBox(
                width: 130,
                height: 50,
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 400),
                  animatedTexts: [
                    RotateAnimatedText(
                      translate(LocaleKeys.onboarding_shopping_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold(
                        color:
                            context.isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    RotateAnimatedText(
                      translate(LocaleKeys.onboarding_learning_plan),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold(
                        color:
                            context.isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    RotateAnimatedText(
                      translate(LocaleKeys.onboarding_todo_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold(
                        color:
                            context.isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    RotateAnimatedText(
                      translate(LocaleKeys.onboarding_any_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold(
                        color:
                            context.isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            translate(LocaleKeys.onboarding_groups),
            style: context.typo.largeBold(
              color: context.isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: Dimens.marginExtraLargeDouble),
          Text(
            translate(LocaleKeys.onboarding_create_lists_together),
            style: context.typo.medium(
              color: context.isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdPage() {
    return Center(
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate(LocaleKeys.onboarding_welcome),
                  style: context.typo.largeBold(
                    color: context.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: Dimens.marginExtraLargeDouble),
                SizedBox(
                  width: 240,
                  child: ChecklistSwitch(
                    label: translate(LocaleKeys.onboarding_dark_mode),
                    value: context.isDarkTheme,
                    onChanged: (value) {
                      BlocProvider.of<ThemeCubit>(context).changeThemeMode(
                        theme: context.isDarkTheme
                            ? checkbox_theme_mode.ThemeMode.light
                            : checkbox_theme_mode.ThemeMode.dark,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: ChecklistSwitch(
                    label: translate(LocaleKeys.onboarding_biometrics),
                    value: state.settings.isBiometricsActive,
                    onChanged: (value) {
                      BlocProvider.of<OnboardingCubit>(context)
                          .setBiometrics();
                    },
                  ),
                ),
              ],
            );
          } else {
            return const ChecklistLoadingIndicator();
          }
        },
      ),
    );
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: ChecklistRoundedButton(
                text: reachedLastPage
                    ? translate(LocaleKeys.onboarding_start)
                    : translate(LocaleKeys.onboarding_next),
                onPressed: () {
                  if (reachedLastPage) {
                    context.router.replace(const TabRouter());
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
            ScaleTransition(
              scale: _animationController,
              child: ChecklistLargeTextButton(
                forward: true,
                text: translate(LocaleKeys.onboarding_skip),
                onPressed: () {
                  context.router.replace(const TabRouter());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
