import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
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
  State<ChecklistDismissibleListItem> createState() =>
      _ChecklistDismissibleListItemState();
}

class _ChecklistDismissibleListItemState
    extends State<ChecklistDismissibleListItem> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.marginMedium),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Dismissible(
          key: widget.key ?? ValueKey(widget.element.name),
          direction: DismissDirection.endToStart,
          background: _buildBackground(),
          onDismissed: (direction) {
            widget.onDismissed();
          },
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: Dimens.marginMedium),
          child: Icon(Icons.delete),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ChecklistListItem(
      roundedCorners: false,
      height: 60,
      onPressed: widget.onPressed,
      leading: widget.checkable ? _buildCheckbox() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.element.name ?? "",
            style: context.typo.mediumBold(color: context.isDarkTheme ? Colors.white : Colors.black),
          ),
          if (widget.element.description?.isNotEmpty == true)
            Text(widget.element.description ?? ""),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Checkbox(
      checkColor: context.isDarkTheme ? Colors.black : Colors.white,
      activeColor: context.isDarkTheme ? Colors.white : Colors.black,
      value: widget.checked,
      onChanged: (isChecked) {
        setState(() {
          widget.onCheckedChanged?.call(isChecked);
          checked = true;
        });
      },
    );
  }
}
