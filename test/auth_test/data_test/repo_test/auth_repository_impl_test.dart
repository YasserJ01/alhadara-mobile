import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/errors/expections.dart';
import 'package:project2/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:project2/features/auth/data/models/login_request_model.dart';
import 'package:project2/features/auth/data/models/register_request_model.dart';
import 'package:project2/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:project2/features/auth/domain/entities/user_entity.dart';

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

  group('register', () {
    const String tFirstName = 'John';
    const String tMiddleName = 'Middle';
    const String tLastName = 'Doe';
    const String tPhone = '1234567890';
    const String tPassword = 'password123';
    const String tConfirmPassword = 'password123';
    const String tAccessToken = 'test_access_token';

    final Map<String, dynamic> tRemoteResponse = {
      'access': tAccessToken,
      'refresh': 'test_refresh_token',
    };

    test('should return access token when registration succeeds', () async {
      // arrange
      when(mockRemoteDataSource.register(any))
          .thenAnswer((_) async => tRemoteResponse);

      // act
      final result = await repository.register(
        tFirstName,
        tMiddleName,
        tLastName,
        tPhone,
        tPassword,
        tConfirmPassword,
      );

      // assert
      expect(result, equals(tAccessToken));
    });

    test('should call remote data source with correct parameters', () async {
      // arrange
      when(mockRemoteDataSource.register(any))
          .thenAnswer((_) async => tRemoteResponse);

      // act
      await repository.register(
        tFirstName,
        tMiddleName,
        tLastName,
        tPhone,
        tPassword,
        tConfirmPassword,
      );

      // assert
      final expectedRequest = RegisterRequestModel(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: tConfirmPassword,
      );

      verify(mockRemoteDataSource.register(argThat(
        predicate<RegisterRequestModel>((request) =>
        request.firstName == expectedRequest.firstName &&
            request.middleName == expectedRequest.middleName &&
            request.lastName == expectedRequest.lastName &&
            request.phone == expectedRequest.phone &&
            request.password == expectedRequest.password &&
            request.confirm_password == expectedRequest.confirm_password),
      )));
    });

    test('should throw ValidationException when remote data source throws it',
            () async {
          // arrange
          when(mockRemoteDataSource.register(any))
              .thenThrow(ValidationnException('Phone number already exists'));

          // act & assert
          expect(
                () => repository.register(
              tFirstName,
              tMiddleName,
              tLastName,
              tPhone,
              tPassword,
              tConfirmPassword,
            ),
            throwsA(isA<ValidationnException>()),
          );
        });

    test('should throw ServerException when remote data source throws it',
            () async {
          // arrange
          when(mockRemoteDataSource.register(any))
              .thenThrow(ServerException('Server error'));

          // act & assert
          expect(
                () => repository.register(
              tFirstName,
              tMiddleName,
              tLastName,
              tPhone,
              tPassword,
              tConfirmPassword,
            ),
            throwsA(isA<ServerException>()),
          );
        });
  });

}
