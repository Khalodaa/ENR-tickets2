// ignore_for_file: unrelated_type_equality_checks

import 'package:enr_tickets/core/widget/assets.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class StationsListView extends StatelessWidget {
  final List<String> stations;
  final String selectedStation;
  final Function(String) onStationSelected;

  const StationsListView({
    super.key,
    required this.stations,
    required this.selectedStation,
    required this.onStationSelected,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];

        final theme = Theme.of(context);

        return Card(
          color: theme.cardColor,
          child: ListTile(
            title: Text(
              station,
              style: Styles.textStyle20.copyWith(
                color: theme.textTheme.bodyLarge!.color,
              ),
            ),
            leading: Image.asset(AssetsData.icontravel, width: 30),
            trailing: station == selectedStation
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              onStationSelected(station);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
