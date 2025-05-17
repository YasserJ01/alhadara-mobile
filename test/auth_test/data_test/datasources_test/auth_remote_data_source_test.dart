import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:project2/features/auth/data/models/login_request_model.dart';
// Import your app files

// Generate mock HTTP client
@GenerateMocks([http.Client])
import 'auth_remote_data_source_test.mocks.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AuthRemoteDataSourceImpl(mockHttpClient);
  });

  group('loginWithPhone', () {
    final loginRequest = LoginRequestModel(
      phone: '0991234567',
      password: 'password123',
    );

    test('should return token data when the response code is 200', () async {
      // Arrange
      final responseData = {
        'access': 'test_access_token',
        'refresh': 'test_refresh_token',
      };

      when(mockHttpClient.post(
        Uri.parse('${dataSource.BaseURL}/api/auth/jwt/create/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
        jsonEncode(responseData),
        200,
      ));

      // Act
      final result = await dataSource.loginWithPhone(loginRequest);

      // Assert
      expect(result, equals(responseData));
      verify(mockHttpClient.post(
        Uri.parse('${dataSource.BaseURL}/api/auth/jwt/create/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginRequest.toJson()),
      ));
    });

    test('should throw an exception when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.post(
        Uri.parse('${dataSource.BaseURL}/api/auth/jwt/create/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
        '{"error": "Invalid credentials"}',
        401,
      ));

      // Act & Assert
      expect(
            () => dataSource.loginWithPhone(loginRequest),
        throwsA(isA<Exception>()),
      );
    });
  });
}