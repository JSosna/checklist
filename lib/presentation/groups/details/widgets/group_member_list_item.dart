import 'package:checklist/localization/keys.g.dart';
import 'package:checklist/style/dimens.dart';
import 'package:checklist/widgets/checklist_dialog_menu_item.dart';
import 'package:checklist/widgets/checklist_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class GroupMemberListItem extends StatefulWidget {
  final String name;
  final VoidCallback onDelete;
  final VoidCallback onHandOverAdmin;
  final bool isCurrentUser;
  final bool isCurrentUserAdmin;

  const GroupMemberListItem({
    required this.name,
    required this.onDelete,
    required this.onHandOverAdmin,
    this.isCurrentUser = false,
    this.isCurrentUserAdmin = false,
  });

  @override
  _GroupMemberListItemState createState() => _GroupMemberListItemState();
}

class _GroupMemberListItemState extends State<GroupMemberListItem> {
  bool _showMoreMenu = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ChecklistListItem(
          onPressed: () {},
          child: Text(widget.name),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _buildTrailing(),
        ),
      ],
    );
  }

  Widget _buildTrailing() {
    if (widget.isCurrentUserAdmin && !widget.isCurrentUser) {
      return _buildMenu();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.marginSmall - 2.0),
      child: PortalEntry(
        visible: _showMoreMenu,
        portal: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _showMoreMenu = false;
            });
          },
        ),
        child: PortalEntry(
          visible: _showMoreMenu,
          portalAnchor: Alignment.topRight,
          childAnchor: Alignment.center,
          portal: _buildMoreMenu(),
          child: IconButton(
            onPressed: () {
              setState(() {
                _showMoreMenu = !_showMoreMenu;
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreMenu() {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChecklistDialogMenuItem(
              text: LocaleKeys.groups_hand_over_admin.tr(),
              onPressed: () {
                setState(() {
                  _showMoreMenu = false;
                });

                widget.onHandOverAdmin();
              },
            ),
            ChecklistDialogMenuItem(
              text: LocaleKeys.groups_remove_member.tr(),
              onPressed: () {
                setState(() {
                  _showMoreMenu = false;
                });

                widget.onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
