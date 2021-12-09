import 'package:flutter/material.dart';

class ChecklistTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const ChecklistTextField({
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
    );
  }
}
