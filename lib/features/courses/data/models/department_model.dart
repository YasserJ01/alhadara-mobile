import 'package:equatable/equatable.dart';

import '../../domain/entites/department.dart';

class DepartmentModel extends Equatable {
  final int id;
  final String name;
  final String description;


  const DepartmentModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  @override
  List<Object> get props => [id, name, description];

Department toEntity() {
  return Department(
    id: id,
    name: name,
    description: description,
  );
}
}