// use_cases/get_loyalty_points.dart
import '../entities/loyalty_points.dart';
import '../repositories/loyalty_points_repository.dart';

class GetLoyaltyPoints {
  final LoyaltyPointsRepository repository;

  GetLoyaltyPoints(this.repository);

  Future<LoyaltyPoints> call() async {
    return await repository.getLoyaltyPoints();
  }
}