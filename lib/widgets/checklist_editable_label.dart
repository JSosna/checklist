import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_dialog.dart';
import 'package:checklist/widgets/checklist_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  final _formKey = GlobalKey<FormState>();
  String? _currentValue;
  late final TextEditingController _controller;

  final nameValidator = MultiValidator([
    RequiredValidator(
      errorText: LocaleKeys.validation_this_field_is_required.tr(),
    ),
    MaxLengthValidator(30, errorText: LocaleKeys.validation_too_long.tr())
  ]);

  @override
  void initState() {
    super.initState();
    _currentValue = widget.text;
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: _openInputDialog,
        child: Container(
          padding: const EdgeInsets.all(Dimens.marginSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currentValue ?? "",
                style: widget.style,
              ),
              const SizedBox(width: Dimens.marginSmall),
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
      builder: (context) => ChecklistDialog(
        title: LocaleKeys.editable_label_edit_label.tr(),
        children: [
          Form(
            key: _formKey,
            child: ChecklistTextField(
              autofocus: true,
              controller: _controller,
              validator: nameValidator,
            ),
          ),
        ],
        onSubmit: () {
          final newValue = _controller.text;

          if (_formKey.currentState?.validate() == true &&
              _currentValue != newValue) {
            Navigator.of(context).pop();

            widget.onChanged(newValue);
            setState(() {
              _currentValue = newValue;
            });
          }
        },
      ),
    );
  }
}
