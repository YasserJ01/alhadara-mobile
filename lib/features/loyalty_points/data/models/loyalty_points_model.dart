// models/loyalty_points_model.dart
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/loyalty_points.dart';

part 'loyalty_points_model.g.dart';

@JsonSerializable()
class LoyaltyPointsModel extends LoyaltyPoints {
  const LoyaltyPointsModel({
    required int? id,
    required int? student,
    required int points,
    required DateTime? updatedAt,
  }) : super(
    id: id,
    student: student,
    points: points,
    updatedAt: updatedAt,
  );

  factory LoyaltyPointsModel.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyPointsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyPointsModelToJson(this);

  factory LoyaltyPointsModel.fromApiResponse(Map<String, dynamic> json) {
    // Handle case where no loyalty points found
    if (json.containsKey('detail') && json.containsKey('points')) {
      return LoyaltyPointsModel(
        id: null,
        student: null,
        points: json['points'] as int,
        updatedAt: null,
      );
    }

    // Handle normal response
    return LoyaltyPointsModel(
      id: json['id'] as int?,
      student: json['student'] as int?,
      points: json['points'] as int,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }
}