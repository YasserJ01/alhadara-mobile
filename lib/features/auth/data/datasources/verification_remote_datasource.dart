// data/datasources/verification_remote_datasource.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../errors/expections.dart';
import '../models/verification_models.dart';

abstract class VerificationRemoteDataSource {
  Future<StartVerificationResponse> startVerification(StartVerificationRequest request);
  Future<void> submitVerification(SubmitVerificationRequest request);
}

class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;

  VerificationRemoteDataSourceImpl(this.client,this.apiClient);

  @override
  Future<StartVerificationResponse> startVerification(StartVerificationRequest request) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/core/auth/verify/start/',
        body: json.encode(
          request.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return StartVerificationResponse.fromJson(responseData);
      } else {
        final responseData = response.body.isNotEmpty
            ? json.decode(response.body)
            : null;

        switch (response.statusCode) {
          case 400:
            throw ValidationException(responseData ?? {});
          case 401:
            throw UnauthorizedException('Unauthorized request');
          case 404:
            throw NotFoundException('Endpoint not found');
          case 500:
            throw ServerException('Internal server error');
          default:
            throw ApiException(
              'Failed to start verification',
              response.statusCode,
              responseData,
            );
        }
      }
    } on ValidationException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } on ServerException {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<void> submitVerification(SubmitVerificationRequest request) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/core/auth/verify/submit/',
        body: json.encode(
          request.toJson(),
        ),
      );

      if (response.statusCode != 200) {
        final responseData = response.body.isNotEmpty
            ? json.decode(response.body)
            : null;

        switch (response.statusCode) {
          case 400:
            throw ValidationException({'pin': 'Invalid verification code'});
          case 401:
            throw UnauthorizedException('Unauthorized request');
          case 404:
            throw NotFoundException('Endpoint not found');
          case 500:
            throw ServerException('Internal server error');
          default:
            throw ApiException(
              'Invalid verification code',
              response.statusCode,
              responseData,
            );
        }
      }
    } on ValidationException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } on ServerException {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }
}
