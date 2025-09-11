// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyPointsModel _$LoyaltyPointsModelFromJson(Map<String, dynamic> json) =>
    LoyaltyPointsModel(
      id: (json['id'] as num?)?.toInt(),
      student: (json['student'] as num?)?.toInt(),
      points: (json['points'] as num).toInt(),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LoyaltyPointsModelToJson(LoyaltyPointsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student': instance.student,
      'points': instance.points,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
