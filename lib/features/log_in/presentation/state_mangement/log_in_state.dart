part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoding extends LogInState {}

final class LogInSuccess extends LogInState {
  final LogInModel model;
  LogInSuccess({required this.model});
}

final class LogInFailure extends LogInState {
  final String error;

  LogInFailure({required this.error});
}
