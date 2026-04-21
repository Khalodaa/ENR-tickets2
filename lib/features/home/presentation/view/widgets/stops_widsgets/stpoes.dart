import 'package:enr_tickets/features/home/presentation/view/widgets/stops_widsgets/station_time_line.dart';
import 'package:flutter/material.dart';

class Stpoes extends StatelessWidget {
  final int stops;
  final List<String>? stopStations;

  const Stpoes({super.key, required this.stops, required this.stopStations});

  @override
  Widget build(BuildContext context) {
    if (stopStations == null || stopStations!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("No stations available"),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$stops Stops",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 250,
          child: ListView.builder(
            itemCount: stopStations!.length,
            itemBuilder: (context, index) {
              return StationTimeline(stations: [stopStations![index]]);
            },
          ),
        ),
      ],
    );
  }
}
