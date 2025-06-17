// auth/data/datasources/auth_remote_data_source.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/token.dart';
import '../../../../errors/expections.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request);

  Future<Map<String, dynamic>> register(RegisterRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String BaseURL = "https://alhadara-production.up.railway.app";

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/jwt/create/'),
      // Replace with your full API endpoint
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String accessToken = responseBody['access'];
      Token.token = accessToken;
      print(Token.token);
      return responseBody as Map<String, dynamic>;

    } else if (response.statusCode == 400) {
      // Handle validation errors
      if (responseBody is Map<String, dynamic>) {
        if (responseBody.containsKey('phone') ||
            responseBody.containsKey('password')) {
          throw ValidationException(responseBody);
        }
      }
      throw ServerException(responseBody.toString());
    } else if (response.statusCode == 401) {
      // Handle unauthorized (wrong credentials)
      throw UnauthorizedException(
          responseBody['detail'] ?? 'Invalid credentials');
    } else {
      throw ServerException('Failed to login: ${response.statusCode}');
    }
  }

  // In auth_remote_data_source.dart
  @override
  Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/users/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    try {
      final responseBody = json.decode(response.body);

      if (response.statusCode == 201) {
        return responseBody;
      } else if (response.statusCode == 400) {
        if (responseBody.containsKey('phone')) {
          throw ValidationnException(responseBody['phone'][0]);
        }
        throw ValidationnException('Invalid registration data');
      } else {
        throw ServerException(
            responseBody['error'] ?? 'Server error ${response.statusCode}',
        );
      }
    } on FormatException {
      throw ServerException('Invalid server response${response.statusCode}');
    }
  }
  // @override
  // Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
  //   final response = await client.post(
  //     Uri.parse('$BaseURL/api/auth/users/'),
  //     // Replace with your full API endpoint
  //     headers: {
  //       'accept': 'application/json',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(request.toJson()),
  //   );
  //   final responseBody = json.decode(response.body);
  //   if (response.statusCode == 201) {
  //     return jsonDecode(response.body) as Map<String, dynamic>;
  //   } else if (response.statusCode == 400) {
  //     if (responseBody.containsKey('phone')) {
  //       final phoneError = (responseBody['phone'] as List).first;
  //       throw ValidationnException(phoneError);
  //     }
  //   } else {
  //     throw ServerException('Failed to login: ${response.statusCode}');
  //   }
  //   throw Exception('Invalid');
  // }
}
