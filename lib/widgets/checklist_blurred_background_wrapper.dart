import 'dart:math';
import 'dart:ui';

import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/colors.dart';
import 'package:checklist/widgets/blurred_background_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChecklistBlurredBackgroundWrapper extends StatefulWidget {
  final Widget child;

  const ChecklistBlurredBackgroundWrapper({
    required this.child,
  });

  @override
  _ChecklistBlurredBackgroundWrapperState createState() =>
      _ChecklistBlurredBackgroundWrapperState();
}

class _ChecklistBlurredBackgroundWrapperState
    extends State<ChecklistBlurredBackgroundWrapper>
    with TickerProviderStateMixin {
  late AnimationController _positionController;
  late AnimationController _colorController;

  late Animation<double> _mainVerticalPositionAnimation;
  late Animation<Color?> _mainColorAnimation;

  final random = Random();

  @override
  void initState() {
    super.initState();
    _positionController = _createPositionController();
    _colorController = _createColorController();

    final Animation<double> positionCurve =
        CurvedAnimation(parent: _positionController, curve: Curves.slowMiddle);

    final Animation<double> colorCurve =
        CurvedAnimation(parent: _colorController, curve: Curves.easeInOut);

    _mainVerticalPositionAnimation =
        Tween<double>(begin: 0, end: 1).animate(positionCurve);

    _mainColorAnimation = ColorTween(
      begin: AppColors.blue,
      end: AppColors.red,
    ).animate(colorCurve);

    _positionController.forward();
    _colorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _positionController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkTheme ? AppColors.darkBackground : Colors.grey[50],
      child: Stack(
        children: [
          _buildBackgroundAnimation(),
          widget.child,
        ],
      ),
    );
  }

  Widget _buildBackgroundAnimation() {
    final size = MediaQuery.of(context).size;

    final startingPositionX =
        context.read<BlurredBackgroundStateProvider>().horizontalPosition;
    final positionX = (startingPositionX ?? 0.0) * size.width / 2;

    const blobSize = 200.0;
    const offset = blobSize + 220.0;
    const sigma = 60.0;
    final positionY = (-offset / 1.4) +
        _mainVerticalPositionAnimation.value * (size.height + offset);

    return Positioned(
      right: positionX,
      top: positionY,
      child: _buildBlob(blobSize, sigma),
    );
  }

  Widget _buildBlob(double blobRadius, double sigma) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
        tileMode: TileMode.decal,
      ),
      child: Container(
        height: blobRadius,
        width: blobRadius,
        decoration: BoxDecoration(
          color: _mainColorAnimation.value,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  AnimationController _createPositionController() {
    return AnimationController(
      value: context
              .read<BlurredBackgroundStateProvider>()
              .verticalPositionState ??
          0,
      vsync: this,
      duration: const Duration(milliseconds: 15000),
    )
      ..addListener(() {
        context.read<BlurredBackgroundStateProvider>().verticalPositionState =
            _positionController.value;
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.reset();
          _positionController.forward();
          context.read<BlurredBackgroundStateProvider>().horizontalPosition =
              random.nextDouble();
          setState(() {});
        }
      });
  }

  AnimationController _createColorController() {
    return AnimationController(
      value: context.read<BlurredBackgroundStateProvider>().colorState ?? 0,
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..addListener(() {
        context.read<BlurredBackgroundStateProvider>().colorState =
            _colorController.value;
        setState(() {});
      });
  }
}
