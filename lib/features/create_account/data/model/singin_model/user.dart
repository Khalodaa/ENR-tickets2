import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const User({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.role,
    this.isVerified,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    phone: json['phone'] as String?,
    role: json['role'] as String?,
    isVerified: json['isVerified'] as bool?,
    id: json['_id'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'role': role,
    'isVerified': isVerified,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  @override
  List<Object?> get props {
    return [
      name,
      email,
      password,
      phone,
      role,
      isVerified,
      id,
      createdAt,
      updatedAt,
      v,
    ];
  }
}
