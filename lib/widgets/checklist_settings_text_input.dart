import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/widgets/checklist_dialog.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:flutter/material.dart';

class ChecklistSettingsTextInput extends StatefulWidget {
  final String title;
  final String value;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  const ChecklistSettingsTextInput({
    required this.title,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  _ChecklistSettingsTextInputState createState() =>
      _ChecklistSettingsTextInputState();
}

class _ChecklistSettingsTextInputState
    extends State<ChecklistSettingsTextInput> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openInputDialog,
      child: SizedBox(
        height: 40.0,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                widget.title,
                style: context.typo.medium(
                  color: context.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value ?? "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: context.typo.medium(
                  color: Colors.grey,
                ),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  void _openInputDialog() {
    showDialog(
      context: context,
      builder: (context) => ChecklistDialog(
        title: widget.title,
        children: [
          Form(
            key: _formKey,
            child: ChecklistTextField(
              autofocus: true,
              controller: controller,
              validator: widget.validator,
            ),
          ),
        ],
        onSubmit: () {
          if (_formKey.currentState?.validate() == true) {
            Navigator.of(context).pop();

            final newValue = controller.text;

            if (value != newValue) {
              widget.onChanged(newValue);
              setState(() {
                value = newValue;
              });
            }
          }
        },
      ),
    );
  }
}
