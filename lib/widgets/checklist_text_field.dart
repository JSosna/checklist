import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final bool? isObscured;
  final String? label;
  final bool autofocus;
  final void Function(String)? onChanged;

  const ChecklistTextField({
    required this.controller,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.isObscured,
    this.label,
    this.autofocus = false,
    this.onChanged,
  });

  @override
  State<ChecklistTextField> createState() => _ChecklistTextFieldState();
}

class _ChecklistTextFieldState extends State<ChecklistTextField> {
  bool? isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isObscured;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: Dimens.marginMedium),
            child: Text(
              widget.label ?? "",
              style: context.typo.mediumBold(
                color: context.isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: Dimens.marginSmall),
        ],
        _buildTextFormField()
      ],
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: widget.controller,
      autofocus: widget.autofocus,
      validator: widget.validator,
      style: context.typo
          .medium(color: context.isDarkTheme ? Colors.white : Colors.black),
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      obscureText: isObscured ?? false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        helperText: "",
        suffixIcon:
            isObscured != null ? _buildSuffixIcon() : const SizedBox.shrink(),
        filled: true,
        fillColor: context.isDarkTheme
            ? Colors.grey[850]?.withOpacity(0.5)
            : Colors.blueGrey[200]?.withOpacity(0.5),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
      icon: Icon(isObscured == true ? Icons.visibility : Icons.visibility_off),
      focusNode: FocusNode(canRequestFocus: false, skipTraversal: true),
      splashRadius: 20.0,
      onPressed: () {
        setState(() {
          if (isObscured != null) {
            isObscured = !isObscured!;
          }
        });
      },
    );
  }
}
