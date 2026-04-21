import 'package:equatable/equatable.dart';

import 'user.dart';

class SinginModel extends Equatable {
  final String? msg;
  final String? token;
  final User? user;

  const SinginModel({this.msg, this.token, this.user});

  factory SinginModel.fromJson(Map<String, dynamic> json) => SinginModel(
    msg: json['msg'] as String?,
    token: json['token'] as String?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'token': token,
    'user': user?.toJson(),
  };

  @override
  List<Object?> get props => [msg, token, user];
}
