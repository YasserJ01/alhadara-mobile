import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/errors/expections.dart';
import 'package:project2/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:project2/features/auth/data/models/login_request_model.dart';
import 'package:project2/features/auth/data/models/register_request_model.dart';
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

  group('register', () {
    final tRegisterRequest = RegisterRequestModel(
      firstName: 'John',
      middleName: 'Middle',
      lastName: 'Doe',
      phone: '1234567890',
      password: 'password123',
      confirm_password: 'password123',
    );

    const tResponse = {
      'access': 'test_access_token',
      'refresh': 'test_refresh_token',
    };

    test('should perform POST request on register endpoint with correct data',
            () async {
          // arrange
          when(mockHttpClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          )).thenAnswer((_) async => http.Response(
            json.encode(tResponse),
            201,
          ));

          // act
          await dataSource.register(tRegisterRequest);

          // assert
          verify(mockHttpClient.post(
            Uri.parse('http://10.0.2.2:8000/api/auth/users/'),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(tRegisterRequest.toJson()),
          ));
        });

    test('should return access token when registration is successful', () async {
      // arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
        json.encode(tResponse),
        201,
      ));

      // act
      final result = await dataSource.register(tRegisterRequest);

      // assert
      expect(result, equals(tResponse));
    });

    test('should throw ValidationException when phone validation fails',
            () async {
          // arrange
          const errorResponse = {
            'phone': ['Phone number already exists']
          };
          when(mockHttpClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          )).thenAnswer((_) async => http.Response(
            json.encode(errorResponse),
            400,
          ));

          // act & assert
          expect(
                () => dataSource.register(tRegisterRequest),
            throwsA(isA<ValidationnException>()),
          );
        });

    test('should throw ServerException when status code is not 201 or 400',
            () async {
          // arrange
          when(mockHttpClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          )).thenAnswer((_) async => http.Response(
            'Something went wrong',
            500,
          ));

          // act & assert
          expect(
                () => dataSource.register(tRegisterRequest),
            throwsA(isA<ServerException>()),
          );
        });
  });

}