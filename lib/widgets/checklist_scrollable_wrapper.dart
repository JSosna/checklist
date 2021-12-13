import 'package:flutter/material.dart';

class ChecklistScrollableWrapper extends StatelessWidget {
  final Widget child;

  const ChecklistScrollableWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        )
      ],
    );
  }
}
