import 'package:bloc/bloc.dart';
import 'package:enr_tickets/core/services/error/failures.dart';
import 'package:enr_tickets/features/create_account/data/model/singin_model/singin_model.dart';
import 'package:enr_tickets/features/create_account/data/repo/signin_repo.dart';
import 'package:meta/meta.dart';

part 'creat_user_state.dart';

class CreatUserCubit extends Cubit<CreatUserState> {
  final SigninRepo signinRepo;

  CreatUserCubit(this.signinRepo) : super(CreatUserInitial());

  Future<void> createUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(CreatUserLoading());

    final result = await signinRepo.signin(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    result.fold(
      (Failure failure) {
        emit(CreatUserFailure(error: failure.errorMessage));
      },
      (SinginModel model) {
        emit(CreatUserSuccess(model: model));
      },
    );
  }
}
