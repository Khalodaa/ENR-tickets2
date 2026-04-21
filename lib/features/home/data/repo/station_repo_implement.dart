import 'package:dio/dio.dart';
import 'package:enr_tickets/core/services/api/api_service.dart';
import 'package:enr_tickets/core/services/api/endpoints.dart';
import 'package:enr_tickets/features/home/data/model/station_model/station_model.dart';
import 'package:enr_tickets/features/home/data/repo/station_repo.dart';

class StationRepoImplement implements StationRepo {
  final ApiService apiService;

  StationRepoImplement(this.apiService);

  @override
  Future<List<StationModel>> getStations() async {
    try {
      final response = await apiService.get(endpoint: EndPoints.getStations);

      print("RESPONSE = ${response.data}");

      final raw = response.data;

      final List list = raw is List
          ? raw
          : raw['data'] is List
          ? raw['data']
          : [];

      return list.map((json) => StationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'] ?? "Something went wrong");
    }
  }
}
