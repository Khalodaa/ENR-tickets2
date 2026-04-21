import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enr_tickets/core/services/api/api_service.dart';
import 'package:enr_tickets/core/services/error/failures.dart';
import 'package:enr_tickets/features/log_in/data/model/LoginModel/log.in_model.dart';
import 'package:enr_tickets/features/log_in/data/repo/login_repo.dart';

class LoginRepoImplement implements LogInRepo {
  final ApiService apiService;

  LoginRepoImplement(this.apiService);

  @override
  Future<Either<Failure, LogInModel>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: "/email/login",
        data: {"email": email, "password": password},
      );

      final model = LogInModel.fromJson(response.data);

      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(e));
    }
  }
}
