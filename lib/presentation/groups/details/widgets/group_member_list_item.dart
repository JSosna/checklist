import 'package:checklist/style/dimens.dart';
import 'package:flutter/material.dart';

class GroupMemberListItem extends StatefulWidget {
  final String name;
  final VoidCallback onDelete;
  final VoidCallback onHandOverAdmin;
  final bool isCurrentUser;

  const GroupMemberListItem({
    required this.name,
    required this.onDelete,
    required this.onHandOverAdmin,
    this.isCurrentUser = false,
  });

  @override
  _GroupMemberListItemState createState() => _GroupMemberListItemState();
}

class _GroupMemberListItemState extends State<GroupMemberListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.kMarginLarge),
      child: ListTile(
        tileColor: Colors.grey.withOpacity(0.5),
        title: Text(widget.name),
      ),
    );
  }
}
