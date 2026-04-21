import 'package:dartz/dartz.dart';
import 'package:enr_tickets/core/services/error/failures.dart';
import 'package:enr_tickets/features/create_account/data/model/singin_model/singin_model.dart';

abstract class SigninRepo {
  Future<Either<Failure, SinginModel>> signin({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
}
