import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/localization/utils.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistEditableLabel extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final void Function(String) onChanged;

  const ChecklistEditableLabel({
    required this.text,
    required this.onChanged,
    this.style,
  });

  @override
  _ChecklistEditableLabelState createState() => _ChecklistEditableLabelState();
}

class _ChecklistEditableLabelState extends State<ChecklistEditableLabel> {
  String? currentValue;
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    currentValue = widget.text;
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: _openInputDialog,
        child: Container(
          padding: const EdgeInsets.all(Dimens.kMarginSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentValue ?? "",
                style: widget.style,
              ),
              const SizedBox(width: Dimens.kMarginSmall),
              const Icon(
                Icons.edit,
                color: Colors.grey,
                size: 22.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openInputDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit text"),
        content: TextField(
          autofocus: true,
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              final newValue = controller?.text;

              if (newValue != null && currentValue != newValue) {
                widget.onChanged(newValue);
                setState(() {
                  currentValue = newValue;
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
