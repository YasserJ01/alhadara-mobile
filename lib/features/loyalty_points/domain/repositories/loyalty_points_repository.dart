// repositories/loyalty_points_repository.dart
import '../entities/loyalty_points.dart';

abstract class LoyaltyPointsRepository {
  Future<LoyaltyPoints> getLoyaltyPoints();
}