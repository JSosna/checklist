import 'package:checklist/extension/context_extension.dart';
import 'package:checklist/style/colors.dart';
import 'package:checklist/widgets/rounded_button.dart';
import 'package:checklist/widgets/vertical_page_indicators.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
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
        setState(() {});
      },
      children: [
        _buildFirstPage(),
        _buildSecondPage(),
        _buildThirdPage(),
      ],
    );
  }

  Widget _buildFirstPage() {
    return Center(child: Text("1"));
  }

  Widget _buildSecondPage() {
    return Center(child: Text("2"));
  }

  Widget _buildThirdPage() {
    return Center(child: Text("3"));
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            const SizedBox(width: 18.0),
            TextButton(
                onPressed: () {},
                child: Text(
                  "skip",
                  style: context.typo.main(color: AppColors.blue),
                )),
            Expanded(
              child: RoundedButton(
                text: "next",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
