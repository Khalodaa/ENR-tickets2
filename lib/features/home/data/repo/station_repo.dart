import 'package:enr_tickets/core/services/api/api_service.dart';
import 'package:enr_tickets/features/home/data/model/station_model/station_model.dart';

abstract class StationRepo {
  StationRepo(ApiService apiService);

  Future<List<StationModel>> getStations();
}