import 'package:flutter/material.dart';

class ChecklistTextField extends StatelessWidget {
  final TextEditingController controller;

  const ChecklistTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    );
  }
}
