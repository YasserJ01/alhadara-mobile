//lib/features/profile/data/models/interest_model.dart
import '../../domain/entity/interest.dart';

class InterestModel extends Interest {
  const InterestModel({
    required super.interest,
    required super.interestName,
    required super.interestCategory,
    required super.intensity,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      interest: json['interest'],
      interestName: json['interest_name'],
      interestCategory: json['interest_category'],
      intensity: json['intensity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'interest': interest,
      'interest_name': interestName,
      'interest_category': interestCategory,
      'intensity': intensity,
    };
  }
}
