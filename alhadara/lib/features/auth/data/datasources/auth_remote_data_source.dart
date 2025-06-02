// auth/data/datasources/auth_remote_data_source.dart
import 'package:alhadara/core/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request);

  Future<Map<String, dynamic>> register(RegisterRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String BaseURL = "http://192.168.1.9:8000"; //192.168.1.9

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
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      String accessToken = jsonData['access'];
      Token.token = accessToken;
      print(Token.token);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(response.body);
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
    final response = await client.post(
      Uri.parse('https://alhadara-production.up.railway.app/api/auth/users/'),
      // Replace with your full API endpoint
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      // Typically 201 for created resources
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(response.body);
      throw Exception('Failed to register: ${response.statusCode}');
    }
  }
}
