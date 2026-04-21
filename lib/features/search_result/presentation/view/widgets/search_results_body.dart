import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/widget/app_lottie_lodaing.dart';
import 'package:enr_tickets/features/search_result/presentation/state_mangement/search_result_cubit/search_result_cubit.dart';
import 'package:enr_tickets/features/search_result/presentation/view/widgets/custom_app_bar_search_results.dart';
import 'package:enr_tickets/features/search_result/presentation/view/widgets/custom_card_train_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchResultsBody extends StatelessWidget {
  final int trainNumber;
  final int availableTickets;
  final int stops;
  final String fromStation;
  final String toStation;
  final String classType;
  final String departTime;
  final String arriveTime;
  final DateTime departDate;
  final String arriveDate;
  final String price;
  final List<String> stopeStation;
  const SearchResultsBody({
    super.key,
    required this.fromStation,
    required this.toStation,
    required this.trainNumber,
    required this.availableTickets,
    required this.stops,
    required this.classType,
    required this.departTime,
    required this.arriveTime,
    required this.departDate,
    required this.arriveDate,
    required this.price,
    required this.stopeStation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: BlocBuilder<SearchResultCubit, SearchResultState>(
        builder: (context, state) {
          if (state is SearchResultLoading) {
            return Center(
              child: AppLottieLoading(
                assetPath: "assets/search_result.json",
                text: AppStrings.of(context, "searchtitle"),
              ),
            );
          } else if (state is SearchResultSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                children: [
                  const Gap(30),

                  //Fixed
                  CustomAppBarSearchResults(
                    arriveStation: toStation,
                    dateday: arriveDate,
                  ),

                  // Scrolling
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.trains.length,

                      itemBuilder: (context, index) {
                        final train = state.trains[index];
                        // return card
                        return CustomCardTrainInfo(
                          stopStations: stopeStation, //done
                          trainNumber: train.trainNumber, //done
                          classType: train.classType, //done
                          fromStation: train.fromStation, //done
                          toStation: train.toStation, //done
                          departTime: train.departTime, //done
                          arriveTime: train.arriveTime, //done
                          departDate: train.departDate, //done
                          arriveDate: train.arriveDate, //done
                          duration: train.duration, //done
                          availableTickets: train.availableTickets, //done
                          stops: stops, //done
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SearchResultFailure) {
            return Center(child: Text(state.errorMessage));
          }
          return SizedBox();
        },
      ),
    );
  }
}
