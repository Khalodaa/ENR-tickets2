import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/home/presentation/view/widgets/stops_widsgets/stpoes.dart';
import 'package:enr_tickets/features/search_result/presentation/view/widgets/available_tickets_widget.dart';
import 'package:enr_tickets/features/search_result/presentation/view/widgets/ticket_text_button_widget.dart';
import 'package:enr_tickets/features/settings/presentation/view/widgets/stations_widget_info.dart';
import 'package:enr_tickets/features/search_result/presentation/view/widgets/train_number_widget.dart';
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/view/seat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CustomCardTrainInfo extends StatefulWidget {
  final int trainNumber;
  final String classType;
  final String fromStation;
  final String toStation;
  final String departTime;
  final String arriveTime;
  final DateTime departDate;
  final String arriveDate;
  final String duration;
  final int availableTickets;
  final int stops;

  final List<String> stopStations;

  const CustomCardTrainInfo({
    super.key,
    required this.trainNumber,
    required this.classType,
    required this.fromStation,
    required this.toStation,
    required this.departTime,
    required this.arriveTime,
    required this.departDate,
    required this.arriveDate,
    required this.duration,
    required this.availableTickets,
    required this.stops,

    required this.stopStations,
  });

  @override
  State<CustomCardTrainInfo> createState() => _CustomCardTrainInfoState();
}

class _CustomCardTrainInfoState extends State<CustomCardTrainInfo> {
  bool isExpanded = false;

  void toggleStops() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Strings translated
    final String priceLabel = AppStrings.of(context, "price");
    final String stopsLabel = AppStrings.of(context, "stops");
    final String choosingSeatLabel = AppStrings.of(context, "choosingSeat");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
      child: Card(
        elevation: 7,
        shadowColor: elevationColor,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? Colors.grey[700]!
                  : Colors.grey.shade300,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row: [Train number] - [Class type]
              TrainNumberRow(trainNumber: widget.trainNumber),
              Divider(),
              Gap(6),

              // train class type
              Text(
                widget.classType,
                style: Styles.textStyle17.copyWith(
                  color: theme.textTheme.bodyLarge!.color,
                ),
              ),
              Divider(),
              const SizedBox(height: 10),

              /// StationsRow
              StationsRow(
                departTime: widget.departTime,
                departDate: widget.departDate,
                fromStation: widget.fromStation,
                arriveTime: widget.arriveTime,
                arriveDate: widget.arriveDate,
                toStation: widget.toStation,
              ),
              Gap(10),
              Divider(),

              /// Duration with price label
              Center(
                child: Text(
                  "$priceLabel ${widget.duration}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Gap(12),

              /// Available tickets
              AvailableTicketsWidget(availableTickets: widget.availableTickets),

              Divider(),

              /// Bottom Row: Stops & Choose seat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketTextButtonWidget(
                    text: "$stopsLabel ${widget.stops}",
                    onTap: toggleStops,
                  ),
                  Container(height: 30, width: 1, color: Colors.grey.shade300),
                  TicketTextButtonWidget(
                    text: choosingSeatLabel,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                SeatSelectionCubit()..loadSeats(60),
                            child: SeatPage(
                              trainNumber: widget.trainNumber,
                              from: widget.fromStation,
                              to: widget.toStation,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Stpoes(
                          stops: widget.stops,
                          stopStations: widget.stopStations,
                        ),
                      )
                    : const SizedBox(),
              ),
              Gap(4),
            ],
          ),
        ),
      ),
    );
  }
}
