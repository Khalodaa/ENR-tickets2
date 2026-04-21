// ignore_for_file: deprecated_member_use

import 'package:enr_tickets/core/utils/colors.dart';
import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const VerifyButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Container(
          height: 55,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: isDark
                ? null
                : const LinearGradient(
                    colors: [darkcolor, deepcolor, deepcolor, darkcolor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : null, // شفافية بسيطة
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              /// light effect
              if (!isDark)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.transparent],
                      ),
                    ),
                  ),
                ),

              /// Text
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
