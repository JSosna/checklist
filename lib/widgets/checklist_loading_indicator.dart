import 'package:checklist/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ChecklistLoadingIndicator extends StatefulWidget {
  final double size;

  const ChecklistLoadingIndicator({Key? key, this.size = 100})
      : super(key: key);

  @override
  _ChecklistLoadingIndicatorState createState() =>
      _ChecklistLoadingIndicatorState();
}

class _ChecklistLoadingIndicatorState extends State<ChecklistLoadingIndicator> {
  late RiveAnimationController _controller;
  final lightAnimation = "assets/animations/checklist_loader_light.riv";
  final darkAnimation = "assets/animations/checklist_loader_dark.riv";

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('animation1');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: RiveAnimation.asset(
        context.isDarkTheme ? lightAnimation : darkAnimation,
      ),
    );
  }
}
