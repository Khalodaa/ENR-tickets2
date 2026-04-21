import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class TrainNumberRow extends StatelessWidget {
  final int trainNumber;

  const TrainNumberRow({super.key, required this.trainNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String trainNumberLabel = AppStrings.of(context, "trainNumber");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Train Number Badge
        TrainNumberBadge(trainNumber: trainNumber),

        /// Text: "Train number: 123"
        Text(
          "$trainNumberLabel: $trainNumber",
          style: Styles.textStyle19.copyWith(
            color: theme.textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }
}

class TrainNumberBadge extends StatelessWidget {
  final int trainNumber;

  const TrainNumberBadge({super.key, required this.trainNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.grey[700]
            : const Color(0xffE9DFC7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Text(
        "$trainNumber",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
