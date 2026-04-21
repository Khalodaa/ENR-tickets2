// ignore_for_file: avoid_print

import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/settings/presentation/view/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';

class SettingsCardWidget extends StatelessWidget {
  final String title;
  final String task;
  final VoidCallback? onTap;

  const SettingsCardWidget({
    super.key,
    required this.title,
    required this.task,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.sizeOf(context).width * 0.99,
              height: MediaQuery.sizeOf(context).height * 0.056,

              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                children: [
                  Text(
                    title,
                    style: Styles.textStyle17.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const Spacer(),
                  TextButtonWidget(
                    icon: Icons.arrow_forward_ios_rounded,
                    task: task,
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
