import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottieLoading extends StatelessWidget {
  final String assetPath;
  final double size;
  final String? text;

  const AppLottieLoading({
    super.key,
    required this.assetPath,
    this.size = 200,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            assetPath,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),

          if (text != null) ...[
            const SizedBox(height: 12),
            Text(text!, style: Styles.textStyle20.copyWith(color: iconColor)),
          ],
        ],
      ),
    );
  }
}
