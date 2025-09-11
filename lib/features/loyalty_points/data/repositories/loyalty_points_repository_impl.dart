// repositories/loyalty_points_repository_impl.dart
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../datasources/loyalty_points_remote_data_source.dart';
import '../../domain/entities/loyalty_points.dart';
import '../../domain/repositories/loyalty_points_repository.dart';

class LoyaltyPointsRepositoryImpl implements LoyaltyPointsRepository {
  final LoyaltyPointsRemoteDataSource remoteDataSource;

  LoyaltyPointsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoyaltyPoints> getLoyaltyPoints() async {
    try {
      final loyaltyPoints = await remoteDataSource.getLoyaltyPoints();
      return loyaltyPoints;
    } on ServerException catch (e) {
      throw ServerFailure();
    } on UnauthorizedException catch (e) {
      throw UnauthorizedFailure();
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        throw NotFoundFailure('No loyalty points found for this user');
      }
      throw HttpFailure();
    } on JsonException catch (e) {
      throw DataFormatFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
