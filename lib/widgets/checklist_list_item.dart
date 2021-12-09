import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final ChecklistElement element;
  final VoidCallback onPressed;
  final VoidCallback onDismissed;

  const ChecklistListItem({
    required Key key,
    required this.element,
    required this.onPressed,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.kMarginMedium).copyWith(top: 0.0),
      child: Dismissible(
        key: key ?? ValueKey(element.name),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete),
          ),
        ),
        onDismissed: (direction) {
          onDismissed();
        },
        child: Container(
          width: double.infinity,
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
      ),
    );
  }
}
