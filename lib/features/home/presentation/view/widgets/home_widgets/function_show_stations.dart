import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/field_select_station.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/home_widgets/stations_list_view.dart';
import 'package:flutter/material.dart';

void showStationsBottomSheet({
  required BuildContext context,
  required List<String> stations,
  required String selectedStation,
  required Function(String) onStationSelected,
}) {
  List<String> filteredStations = List.from(stations);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 200 * (1 - value)), // يظهر من الأسفل تدريجيًا
            child: Opacity(
              opacity: value,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        /// search field
                        SearchField(
                          onChanged: (value) {
                            setState(() {
                              filteredStations = stations
                                  .where(
                                    (station) => station.toLowerCase().contains(
                                      value.toLowerCase(),
                                    ),
                                  )
                                  .toList();
                            });
                          },
                        ),

                        /// stations list
                        Expanded(
                          child: StationsListView(
                            stations: filteredStations,
                            selectedStation: selectedStation,
                            onStationSelected: onStationSelected,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}
