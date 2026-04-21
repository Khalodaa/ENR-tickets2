import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final IconData icon;
  final String task;
  final void Function()? onPressed;

  const TextButtonWidget({
    super.key,
    required this.task,
    this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Text(task, style: Styles.textStyle17.copyWith(color: buttonColor)),
            const SizedBox(width: 20),
            Icon(icon, color: iconColor, size: 30),
          ],
        ),
      ),
    );
  }
}
