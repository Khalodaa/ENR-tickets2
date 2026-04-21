import 'package:dio/dio.dart';
import 'package:enr_tickets/core/utils/local_storage.dart';

class ApiService {
  final String _baseUrl = "http://10.0.2.2:5000/api/v1";
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = _baseUrl;

    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    /// 🔥 INTERCEPTOR (IMPORTANT)
 _dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await LocalStorage.getToken();

      print("🔥 TOKEN IN REQUEST = $token");

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      return handler.next(options);
    },
  ),
);
  }

  /// GET
  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(endpoint, queryParameters: query);
  }

  /// POST
  Future<Response> post({
    required String endpoint,
    dynamic data,
  }) async {
    return await _dio.post(endpoint, data: data);
  }

  /// PUT
  Future<Response> put({
    required String endpoint,
    dynamic data,
  }) async {
    return await _dio.put(endpoint, data: data);
  }

  /// DELETE
  Future<Response> delete({
    required String endpoint,
  }) async {
    return await _dio.delete(endpoint);
  }
}