import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:flutter/material.dart';

class ChecklistSettingsTextInput extends StatefulWidget {
  final String title;
  final String value;
  final void Function(String) onChanged;

  const ChecklistSettingsTextInput({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  _ChecklistSettingsTextInputState createState() =>
      _ChecklistSettingsTextInputState();
}

class _ChecklistSettingsTextInputState
    extends State<ChecklistSettingsTextInput> {
  TextEditingController? controller;
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    controller?.dispose();
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
      builder: (context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          autofocus: true,
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              final newValue = controller?.text;

              if (newValue != null && value != newValue) {
                widget.onChanged(newValue);
                setState(() {
                  value = newValue;
                });
              }
            },
            child: Text(translate(LocaleKeys.general_submit)),
          )
        ],
      ),
    );
  }
}
