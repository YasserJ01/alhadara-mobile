// features/profile/data/models/studyfield_model.dart
import '../../domain/entity/studyfield.dart';

class StudyfieldModel extends Studyfield {
  const StudyfieldModel({
    required super.id,
    required super.name,
  });

  factory StudyfieldModel.fromJson(Map<String, dynamic> json) {
    return StudyfieldModel(
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