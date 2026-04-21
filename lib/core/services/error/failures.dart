import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailuer extends Failure {
  ServerFailuer(super.errorMessage);

  factory ServerFailuer.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuer("connection Time out with APIServer");
      case DioExceptionType.sendTimeout:
        return ServerFailuer("Send Time out");
      case DioExceptionType.receiveTimeout:
        return ServerFailuer("Receive Time out with APIServer");
      case DioExceptionType.badCertificate:
        return ServerFailuer("bad Certificate with APIServer");
      case DioExceptionType.badResponse:
        return ServerFailuer.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailuer("You`r Requst was Cancel");
      case DioExceptionType.connectionError:
        return ServerFailuer("Connection Error");
      case DioExceptionType.unknown:
        return ServerFailuer("Unknown Error,please try agin later");
    }
  }

  factory ServerFailuer.fromResponse(int statusCode, dynamic response) {
    if (response == null) {
      return ServerFailuer("Unexpected server error");
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailuer(
        response['message'] ?? response['msg'] ?? "Authentication Error",
      );
    } else if (statusCode == 404) {
      return ServerFailuer("Your Request not Found, Please try later");
    } else if (statusCode == 500) {
      return ServerFailuer("Internal Server Error, Please try later");
    } else if (statusCode == 429) {
      return ServerFailuer("Too many requests, try again later");
    } else {
      return ServerFailuer("Unexpected Error occurred");
    }
  }
}
