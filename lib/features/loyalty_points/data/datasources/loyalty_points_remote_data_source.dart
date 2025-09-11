// data_sources/loyalty_points_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_client.dart';
import '../../../../errors/expections.dart';
import '../models/loyalty_points_model.dart';

abstract class LoyaltyPointsRemoteDataSource {
  Future<LoyaltyPointsModel> getLoyaltyPoints();
}

class LoyaltyPointsRemoteDataSourceImpl
    implements LoyaltyPointsRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;

  LoyaltyPointsRemoteDataSourceImpl(
    this.client,
    this.apiClient,
  );

  @override
  Future<LoyaltyPointsModel> getLoyaltyPoints() async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/loyaltypoints/me/',
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return LoyaltyPointsModel.fromApiResponse(jsonData);
      } else if (response.statusCode == 404) {
        // Handle not found case - return model with 0 points
        return const LoyaltyPointsModel(
          id: null,
          student: null,
          points: 0,
          updatedAt: null,
        );
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else {
        throw ApiException(
          'Failed to fetch loyalty points',
          response.statusCode,
          response.body,
        );
      }
    } catch (e) {
      if (e is UnauthorizedException || e is ApiException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}
