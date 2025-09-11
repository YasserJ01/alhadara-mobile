import 'package:equatable/equatable.dart';
import '../../domain/entites/department.dart';
import 'package:hive/hive.dart';

part 'department_model.g.dart'; // Generated file

@HiveType(typeId: 0) // Unique typeId for each model
class DepartmentModel extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
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
  DepartmentModel copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
