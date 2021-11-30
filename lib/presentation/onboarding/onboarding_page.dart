import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:checklist/extension/context_extension.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/routing/router.gr.dart';
import 'package:checklist/style/colors.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_rounded_button.dart';
import 'package:checklist/widgets/checklist_switch.dart';
import 'package:checklist/widgets/vertical_page_indicators.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
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
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          _buildPageView(),
          VerticalPageIndicators(
              controller: _pageController, indicatorsCount: 3),
          _buildControls(),
        ],
      ),
    ));
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
        Text(translate(LocaleKeys.onboarding_lists),
            style: context.typo.largeBold()),
        const SizedBox(height: Dimens.kMarginExtraLargeDouble),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: Dimens.kMarginMedium),
            Text(
              translate(LocaleKeys.onboarding_create),
              style: context.typo.medium(),
            ),
            const SizedBox(width: Dimens.kMarginMedium),
            SizedBox(
              width: 130,
              height: 40,
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 400),
                animatedTexts: [
                  RotateAnimatedText(
                      translate(LocaleKeys.onboarding_shopping_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold()),
                  RotateAnimatedText(
                      translate(LocaleKeys.onboarding_learning_plan),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold()),
                  RotateAnimatedText(translate(LocaleKeys.onboarding_todo_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold()),
                  RotateAnimatedText(translate(LocaleKeys.onboarding_any_list),
                      alignment: Alignment.centerLeft,
                      textStyle: context.typo.mediumBold()),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildSecondPage() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(translate(LocaleKeys.onboarding_groups),
            style: context.typo.largeBold()),
        const SizedBox(height: Dimens.kMarginExtraLargeDouble),
        Text(translate(LocaleKeys.onboarding_create_lists_together),
            style: context.typo.medium()),
      ],
    ));
  }

  Widget _buildThirdPage() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(translate(LocaleKeys.onboarding_welcome),
            style: context.typo.largeBold()),
        const SizedBox(height: Dimens.kMarginExtraLargeDouble),
        SizedBox(
            width: 240,
            child: ChecklistSwitch(
                label: translate(LocaleKeys.onboarding_dark_mode),
                value: false,
                onChanged: (value) {})),
        SizedBox(
            width: 240,
            child: ChecklistSwitch(
                label: translate(LocaleKeys.onboarding_biometrics),
                value: false,
                onChanged: (value) {})),
      ],
    ));
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            ScaleTransition(
              scale: _animationController,
              child: TextButton(
                  onPressed: () {
                    context.router.replace(const TabRoute());
                  },
                  child: Text(
                    translate(LocaleKeys.onboarding_skip),
                    style: context.typo.medium(color: AppColors.blue),
                  )),
            ),
            Expanded(
              child: ChecklistRoundedButton(
                text: reachedLastPage
                    ? translate(LocaleKeys.onboarding_start)
                    : translate(LocaleKeys.onboarding_next),
                onPressed: () {
                  if (reachedLastPage) {
                    context.router.replace(const TabRoute());
                  } else {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
