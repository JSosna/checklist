import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final Key key;
  final ChecklistElement element;
  final VoidCallback onPressed;

  const ChecklistListItem(
      {required this.key, required this.element, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.kMarginMedium).copyWith(top: 0.0),
      child: Material(
        color: Colors.grey.withOpacity(0.5),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.kMarginMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(element.name ?? ""),
                Text(element.description ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
