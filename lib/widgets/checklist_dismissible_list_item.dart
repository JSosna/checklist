import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistDismissibleListItem extends StatefulWidget {
  final ChecklistElement element;
  final VoidCallback onPressed;
  final VoidCallback onDismissed;
  final bool checkable;
  final bool checked;
  final void Function(bool?)? onCheckedChanged;

  const ChecklistDismissibleListItem({
    required Key key,
    required this.element,
    required this.onPressed,
    required this.onDismissed,
    this.checkable = false,
    this.checked = false,
    this.onCheckedChanged,
  }) : super(key: key);

  @override
  State<ChecklistDismissibleListItem> createState() => _ChecklistDismissibleListItemState();
}

class _ChecklistDismissibleListItemState extends State<ChecklistDismissibleListItem> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.marginMedium).copyWith(top: 0.0),
      child: Dismissible(
        key: widget.key ?? ValueKey(widget.element.name),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete),
          ),
        ),
        onDismissed: (direction) {
          widget.onDismissed();
        },
        child: Container(
          width: double.infinity,
          color: Colors.grey.withOpacity(0.5),
          child: InkWell(
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.marginMedium),
              child: Row(
                children: [
                  if (widget.checkable)
                    Checkbox(
                      value: widget.checked,
                      onChanged: (isChecked) {
                        setState(() {
                          widget.onCheckedChanged?.call(isChecked);
                          checked = true;
                        });
                      },
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.element.name ?? ""),
                      Text(widget.element.description ?? ""),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
