import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:checklist/widgets/checklist_loading_indicator.dart';
import 'package:flutter/material.dart';

class ChecklistLoadingView extends StatelessWidget {
  const ChecklistLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ChecklistLoadingIndicator(),
        ),
      ),
    );
  }
}
