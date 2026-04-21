import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> sendResetCode(String email) async {
    emit(ResetPasswordLoding());
    try {
      await Future.delayed(const Duration(seconds: 3));
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
