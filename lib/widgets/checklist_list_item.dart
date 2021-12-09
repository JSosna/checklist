import 'package:checklist/domain/checklists/checklist_element.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  final ChecklistElement element;

  const ChecklistListItem({required Key key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.kMarginMedium).copyWith(top: 0.0),
      child: Container(
        padding: const EdgeInsets.all(Dimens.kMarginMedium),
        color: Colors.grey.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(element.name ?? ""),
            Text(element.description ?? ""),
          ],
        ),
      ),
    );
  }
}
