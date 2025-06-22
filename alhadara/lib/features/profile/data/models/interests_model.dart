
import '../../domain/entity/interests.dart';

class InterestsModel {
  final int id;
  final String name;
  final String category;

  InterestsModel({
    required this.id,
    required this.name,
    required this.category,
  });

  factory InterestsModel.fromJson(Map<String, dynamic> json) {
    return InterestsModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }
  InterestEntity toEntity() {
    return InterestEntity(
      id: id,
      name: name,
      category: category,
    );
  }
}
