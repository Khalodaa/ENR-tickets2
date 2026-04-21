// ignore_for_file: deprecated_member_use

import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class SwitchCardSettings extends StatefulWidget {
  final String title;
  final void Function(bool)? onChanged;

  const SwitchCardSettings({super.key, required this.title, this.onChanged});

  @override
  State<SwitchCardSettings> createState() => _SwitchCardSettingsState();
}

class _SwitchCardSettingsState extends State<SwitchCardSettings> {
  bool value = false; // حالة السويتش

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Theme.of(context).cardColor, // 👈 ديناميكي حسب الثيم
        child: SwitchListTile(
          title: Text(
            widget.title,
            style: Styles.hintStyle.copyWith(
              fontSize: 15,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge!.color, // 👈 نص ديناميكي
            ),
          ),
          activeColor: buttonColor,
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
            widget.onChanged?.call(newValue);
          },
        ),
      ),
    );
  }
}
