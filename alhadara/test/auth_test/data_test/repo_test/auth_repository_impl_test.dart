import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:alhadara/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:alhadara/features/auth/data/models/login_request_model.dart';
import 'package:alhadara/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:alhadara/features/auth/domain/entities/user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';
// Import your app files

// Generate mock data source
@GenerateMocks([AuthRemoteDataSource])

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('loginWithPhone', () {
    final phone = '0991234567';
    final password = 'password123';
    final loginRequest = LoginRequestModel(
      phone: phone,
      password: password,
    );
    final responseData = {
      'access': 'test_access_token',
      'refresh': 'test_refresh_token',
    };
    final expectedUser = UserEntity(
      phone: phone,
      accessToken: 'test_access_token',
      refreshToken: 'test_refresh_token',
    );

    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(mockRemoteDataSource.loginWithPhone(any))
          .thenAnswer((_) async => responseData);

      // Act
      final result = await repository.loginWithPhone(phone, password);

      // Assert
      expect(result.phone, equals(phone));
      expect(result.accessToken, equals('test_access_token'));
      expect(result.refreshToken, equals('test_refresh_token'));
      verify(mockRemoteDataSource.loginWithPhone(any));
    });

    test('should propagate the exception when remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.loginWithPhone(any))
          .thenThrow(Exception('Failed to login'));

      // Act & Assert
      expect(
            () => repository.loginWithPhone(phone, password),
        throwsA(isA<Exception>()),
      );
      verify(mockRemoteDataSource.loginWithPhone(any));
    });
  });
}
