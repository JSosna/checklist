import 'dart:io';
import 'package:checklist/extension/context_extensions.dart';
import 'package:checklist/style/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChecklistSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ChecklistSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimens.kMarginLargeDouble),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typo.medium(
                color: context.isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 40.0, child: _buildSwitch()),
        ],
      ),
    );
  }

  Widget _buildSwitch() {
    if (Platform.isIOS) {
      return _buildCupertinoSwitch();
    }
    return _buildMaterialSwitch();
  }

  Widget _buildCupertinoSwitch() {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
      trackColor: Colors.red,
    );
  }

  Widget _buildMaterialSwitch() {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: Colors.green,
      inactiveTrackColor: Colors.red,
      thumbColor: MaterialStateProperty.all(Colors.white),
    );
  }
}
