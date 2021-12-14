import 'package:checklist/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class VerticalPageIndicators extends StatefulWidget {
  final PageController controller;
  final int indicatorsCount;

  const VerticalPageIndicators({
    Key? key,
    required this.controller,
    required this.indicatorsCount,
  }) : super(key: key);

  @override
  _VerticalPageIndicatorsState createState() => _VerticalPageIndicatorsState();
}

class _VerticalPageIndicatorsState extends State<VerticalPageIndicators> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.indicatorsCount,
          (index) => _buildIndicator(
              index == (widget.controller.page?.round() ?? 0), () {
            setState(() {
              widget.controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          }),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 11.0,
          height: isActive ? 42.0 : 11.0,
          decoration: BoxDecoration(
            color: context.isDarkTheme ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: context.isDarkTheme ? Colors.white : Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
