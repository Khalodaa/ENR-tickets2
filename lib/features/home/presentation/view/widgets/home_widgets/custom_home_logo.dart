// ignore_for_file: deprecated_member_use

import 'package:enr_tickets/core/widget/assets.dart';
import 'package:flutter/material.dart';

class CustomHomeLogo extends StatelessWidget {
  const CustomHomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark
          ? Colors.black.withOpacity(0.2) // Dark Mode
          : Colors.white.withOpacity(0.2), // Light Mode
      child: Center(
        child: Image.asset(
          isDark
              ? AssetsData
                    .logo // صورة للـ Dark Mode
              : AssetsData.iconlogo,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
