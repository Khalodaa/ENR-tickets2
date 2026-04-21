import 'package:equatable/equatable.dart';

class StationModel extends Equatable {
  final String id;
  final String name;

  const StationModel({
    required this.id,
    required this.name,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}