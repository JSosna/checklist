import 'package:checklist/domain/groups/group.dart';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/utlis/color_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChecklistGroupIcon extends StatelessWidget {
  final Group group;

  const ChecklistGroupIcon({required this.group});

  @override
  Widget build(BuildContext context) {
    final color =
        Provider.of<ColorGenerator>(context).generateColor(group.id ?? "");
    final name = _getInitials(group.name ?? "");

    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          name,
          style: context.typo.medium(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  String _getInitials(String groupName) {
    return groupName.characters.first;
  }
}
