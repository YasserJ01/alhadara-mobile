// entities/loyalty_points.dart
import 'package:equatable/equatable.dart';

class LoyaltyPoints extends Equatable {
  final int? id;
  final int? student;
  final int points;
  final DateTime? updatedAt;

  const LoyaltyPoints({
    required this.id,
    required this.student,
    required this.points,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, student, points, updatedAt];

  bool get hasLoyaltyPoints => id != null && points > 0;
}
