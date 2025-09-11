// auth/data/datasources/auth_remote_data_source.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/services/token_service.dart';
import '../../../../errors/expections.dart';
import '../models/captcha_response_model.dart';
import '../models/login_request_model.dart';
import '../models/refresh_token_request_model.dart';
import '../models/register_request_model.dart';
import '../models/token_response_model.dart';
import '../models/verification_models.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponseModel> loginWithPhone(LoginRequestModel request);

  Future<TokenResponseModel> refreshToken(String refreshToken);

  Future<Map<String, dynamic>> register(RegisterRequestModel request);

  Future<CaptchaResponseModel> getCaptcha();
  Future<bool> verifyCaptcha(String key, String answer);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String BaseURL = "https://alhadara-production.up.railway.app";

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<TokenResponseModel> loginWithPhone(LoginRequestModel request) async {
    final response = await client.post(
      Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/auth/jwt/create/'),
      // Uri.parse('http://192.168.1.3:8000/api/auth/jwt/create/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final tokenResponse = TokenResponseModel.fromJson(responseBody);

      // Save tokens securely
      await TokenService.saveTokens(
        accessToken: tokenResponse.access,
        refreshToken: tokenResponse.refresh,
      );

      return tokenResponse;
    } else if (response.statusCode == 400) {
      if (responseBody is Map<String, dynamic>) {
        if (responseBody.containsKey('phone') ||
            responseBody.containsKey('password')) {
          throw ValidationException(responseBody);
        }
      }
      throw ServerException(responseBody.toString());
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(
          responseBody['detail'] ?? 'Invalid credentials');
    } else {
      throw ServerException('Failed to login: ${response.statusCode}');
    }
  }

  @override
  Future<TokenResponseModel> refreshToken(String refreshToken) async {
    final request = RefreshTokenRequestModel(refresh: refreshToken);

    final response = await client.post(
      // Uri.parse('http://192.168.1.3:8000/api/auth/jwt/refresh/'),
      Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/auth/jwt/refresh/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final tokenResponse = TokenResponseModel.fromJson(responseBody);

      // Save new tokens
      await TokenService.saveTokens(
        accessToken: tokenResponse.access,
        refreshToken: tokenResponse.refresh,
      );

      return tokenResponse;
    } else if (response.statusCode == 401) {
      // Refresh token is invalid or expired
      await TokenService.clearTokens();
      throw UnauthorizedException('Session expired. Please login again.');
    } else {
      throw ServerException('Failed to refresh token: ${response.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
    final response = await client.post(
      // Uri.parse('http://10.0.2.2:8000/api/auth/users/'),
      Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/auth/users/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    try {
      final responseBody = json.decode(response.body);

      if (response.statusCode == 201) {
        final tokenResponse = TokenResponseModel.fromJson(responseBody);

        // Save tokens securely
        await TokenService.saveTokens(
          accessToken: tokenResponse.access,
          refreshToken: tokenResponse.refresh,
        );

        // return tokenResponse;
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
  @override
  Future<CaptchaResponseModel> getCaptcha() async {
    final response = await client.get(
      // Uri.parse('http://192.168.1.3:8000/api/core/api/captcha/'),
      Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/core/api/captcha/'),
      // Uri.parse('http://10.0.2.2:8000/api/core/api/captcha/'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return CaptchaResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load CAPTCHA. Please try again.');
    }
  }


  @override
  Future<bool> verifyCaptcha(String key, String answer) async {
    final response = await client.post(
      // Uri.parse('http://10.0.2.2:8000/api/core/api/captcha/verify/'),
      // Uri.parse('http://192.168.1.3:8000/api/core/api/captcha/verify/'),
      Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/core/api/captcha/verify/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'key': key,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['valid'] ?? false; // true or false
    } else {
      // بدل ما نرمي Exception، نرجع false
      return false;
    }
  }
}
