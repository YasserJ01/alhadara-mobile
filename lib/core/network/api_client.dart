// core/network/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../services/token_service.dart';
import '../../errors/expections.dart';

class ApiClient {
  final http.Client _client;
  final AuthRemoteDataSource _authDataSource;
  final String baseUrl = "https://optimum-kodiak-hardy.ngrok-free.app";
  // final String baseUrl = "http://10.0.2.2:8000";
  // final String baseUrl = "http://192.168.1.3:8000";

  ApiClient(this._client, this._authDataSource);

  // Make authenticated requests with automatic token refresh
  Future<http.Response> authenticatedRequest({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? jsonBody, // Add this for easier JSON handling
  }) async {
    // Get current access token
    String? accessToken = await TokenService.getAccessToken();

    // Check if we need to refresh the token
    if (accessToken == null || await TokenService.isAccessTokenExpired()) {
      await _refreshTokenIfNeeded();
      accessToken = await TokenService.getAccessToken();
    }

    if (accessToken == null) {
      throw UnauthorizedException('No valid token available');
    }

    // Prepare headers
    final requestHeaders = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'JWT $accessToken',
      ...?headers,
    };

    // Prepare the request body
    Object? requestBody = body;
    if (jsonBody != null) {
      requestBody = jsonEncode(jsonBody);
    }

    // Make the request
    http.Response response;
    final uri = Uri.parse('$baseUrl$endpoint');

    switch (method.toUpperCase()) {
      case 'GET':
        response = await _client.get(uri, headers: requestHeaders);
        break;
      case 'POST':
        response = await _client.post(uri, headers: requestHeaders, body: requestBody);
        break;
      case 'PUT':
        response = await _client.put(uri, headers: requestHeaders, body: requestBody);
        break;
      case 'DELETE':
        response = await _client.delete(uri, headers: requestHeaders);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }

    // If we get 401, try to refresh token once and retry
    if (response.statusCode == 401) {
      await _refreshTokenIfNeeded();
      accessToken = await TokenService.getAccessToken();

      if (accessToken == null) {
        throw UnauthorizedException('Session expired. Please login again.');
      }

      // Update authorization header and retry
      requestHeaders['Authorization'] = 'JWT $accessToken';

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await _client.post(uri, headers: requestHeaders, body: requestBody);
          break;
        case 'PUT':
          response = await _client.put(uri, headers: requestHeaders, body: requestBody);
          break;
        case 'DELETE':
          response = await _client.delete(uri, headers: requestHeaders);
          break;
      }
    }

    return response;
  }

  Future<void> _refreshTokenIfNeeded() async {
    final refreshToken = await TokenService.getRefreshToken();

    if (refreshToken == null || await TokenService.isRefreshTokenExpired()) {
      await TokenService.clearTokens();
      throw UnauthorizedException('Session expired. Please login again.');
    }

    try {
      await _authDataSource.refreshToken(refreshToken);
    } catch (e) {
      await TokenService.clearTokens();
      rethrow;
    }
  }
}


// class ApiClient {
//   final http.Client _client;
//   final AuthRemoteDataSource _authDataSource;
//   final String baseUrl = "http://10.0.2.2:8000";
//
//   ApiClient(this._client, this._authDataSource);
//
//   // Make authenticated requests with automatic token refresh
//   Future<http.Response> authenticatedRequest({
//     required String method,
//     required String endpoint,
//     Map<String, String>? headers,
//     Object? body,
//   }) async {
//     // Get current access token
//     String? accessToken = await TokenService.getAccessToken();
//
//     // Check if we need to refresh the token
//     if (accessToken == null || await TokenService.isAccessTokenExpired()) {
//       await _refreshTokenIfNeeded();
//       accessToken = await TokenService.getAccessToken();
//     }
//
//     if (accessToken == null) {
//       throw UnauthorizedException('No valid token available');
//     }
//
//     // Prepare headers
//     final requestHeaders = {
//       'Content-Type': 'application/json',
//       'Authorization': 'JWT $accessToken',
//       ...?headers,
//     };
//
//     // Make the request
//     http.Response response;
//     final uri = Uri.parse('$baseUrl$endpoint');
//
//     switch (method.toUpperCase()) {
//       case 'GET':
//         response = await _client.get(uri, headers: requestHeaders);
//         break;
//       case 'POST':
//         response = await _client.post(uri, headers: requestHeaders, body: body);
//         break;
//       case 'PUT':
//         response = await _client.put(uri, headers: requestHeaders, body: body);
//         break;
//       case 'DELETE':
//         response = await _client.delete(uri, headers: requestHeaders);
//         break;
//       default:
//         throw ArgumentError('Unsupported HTTP method: $method');
//     }
//
//     // If we get 401, try to refresh token once and retry
//     if (response.statusCode == 401) {
//       await _refreshTokenIfNeeded();
//       accessToken = await TokenService.getAccessToken();
//
//       if (accessToken == null) {
//         throw UnauthorizedException('Session expired. Please login again.');
//       }
//
//       // Update authorization header and retry
//       requestHeaders['Authorization'] = 'JWT $accessToken';
//
//       switch (method.toUpperCase()) {
//         case 'GET':
//           response = await _client.get(uri, headers: requestHeaders);
//           break;
//         case 'POST':
//           response = await _client.post(uri, headers: requestHeaders, body: body);
//           break;
//         case 'PUT':
//           response = await _client.put(uri, headers: requestHeaders, body: body);
//           break;
//         case 'DELETE':
//           response = await _client.delete(uri, headers: requestHeaders);
//           break;
//       }
//     }
//
//     return response;
//   }
//
//   Future<void> _refreshTokenIfNeeded() async {
//     final refreshToken = await TokenService.getRefreshToken();
//
//     if (refreshToken == null || await TokenService.isRefreshTokenExpired()) {
//       await TokenService.clearTokens();
//       throw UnauthorizedException('Session expired. Please login again.');
//     }
//
//     try {
//       await _authDataSource.refreshToken(refreshToken);
//     } catch (e) {
//       await TokenService.clearTokens();
//       rethrow;
//     }
//   }
// }
