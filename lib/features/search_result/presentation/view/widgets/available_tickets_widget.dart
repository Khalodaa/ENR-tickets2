import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AvailableTicketsWidget extends StatelessWidget {
  final int availableTickets;
  const AvailableTicketsWidget({super.key, required this.availableTickets});

  @override
  Widget build(BuildContext context) {
    final String availabletickets = AppStrings.of(context, "availabletickets");
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: Text(
        "$availabletickets: $availableTickets",
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
