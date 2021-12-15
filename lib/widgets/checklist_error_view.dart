import 'package:checklist/widgets/checklist_blurred_background_wrapper.dart';
import 'package:flutter/material.dart';

class ChecklistErrorView extends StatelessWidget {
  final String message;

  const ChecklistErrorView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChecklistBlurredBackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text(
            message,
          ),
        ),
      ),
    );
  }
}
