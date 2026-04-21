// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:enr_tickets/features/home/data/repo/station_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    final StationRepo stationRepo;

  HomeCubit(this.stationRepo) : super(HomeInitial());

  /// Stations list
  List<String> stations = [];

  /// Stop Stations
  List<String> stopStations = [
    "Cairo",
    "Giza",
    "Beni Suef",
    "Maghagha",
    "Minya",
    "Malawi",
    "Deirut",
    "Asyut",
    "Tema",
    "Tahta",
    "Sohag",
    "gerga",
  ];

  /// Selected Data
  String fromStation = "From Station";
  String toStation = "To Station";
  DateTime travelDate = DateTime.now();

  /// Load Stations (later from API)
  Future<void> getStations() async {
    try {
      emit(HomeLoding());

final result = await stationRepo.getStations();
    stations = result.map((e) => e.name).toList();

   



      emit(HomeSuccess(stations: stations));
    } catch (e) {
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }

  /// Update Stations (change defult value to navigator)
  void updateStations(String from, String to) {
    fromStation = from;
    toStation = to;
    emit(HomeSuccess(stations: stations));
  }

  /// Update Date  (change defult value date )
  void updateDate(DateTime date) {
    travelDate = date;
    emit(HomeSuccess(stations: stations));
  }

  /// Update Trip Type

  /// Search Trip
  void searchTrip() {
    if (fromStation == "From Station" || toStation == "To Station") {
      emit(HomeFailure(errorMessage: "Please choose stations correctly"));
      return;
    }

    emit(
      HomeSearchSuccess(
        from: fromStation,
        to: toStation,
        date: travelDate,

        stopStation: stopStations,
      ),
    );
  }
}
