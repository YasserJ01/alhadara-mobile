// features/profile/data/models/university_model.dart
import '../../domain/entity/university.dart';

class UniversityModel extends University {
  const UniversityModel({
    required super.id,
    required super.name,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}