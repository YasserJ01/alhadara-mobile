import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:alhadara/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:alhadara/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:alhadara/features/auth/domain/usecases/login_with_phone_usecase.dart';
import 'package:alhadara/features/auth/presentation/bloc/auth_bloc.dart';
import 'dart:convert';
// Import your app files

// Generate mock HTTP client
@GenerateMocks([http.Client])
import 'login_flow_test.mocks.dart';

void main() {
  late MockClient mockHttpClient;
  late AuthRemoteDataSourceImpl dataSource;
  late AuthRepositoryImpl repository;
  late LoginWithPhoneUseCase useCase;
  late AuthBloc authBloc;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AuthRemoteDataSourceImpl(mockHttpClient);
    repository = AuthRepositoryImpl(dataSource);
    useCase = LoginWithPhoneUseCase(repository);
    authBloc = AuthBloc(loginWithPhoneUseCase: useCase);
  });

  tearDown(() {
    authBloc.close();
  });

  test('Full login flow integration test - success case', () async {
    // Arrange
    final phone = '0991234567';
    final password = 'password123';
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

    // Act & Assert
    // First, check that we're starting with AuthInitial
    expect(authBloc.state, isA<AuthInitial>());

    // Add the login event
    authBloc.add(LoginWithPhoneRequested(phone, password));

    // Use emitsInOrder to check state transitions
    await expectLater(
      authBloc.stream,
      emitsInOrder([
        isA<AuthLoading>(),
        isA<AuthSuccess>(),
      ]),
    );

    // Additional verification after the state transitions
    final currentState = authBloc.state;
    expect(currentState, isA<AuthSuccess>());
    if (currentState is AuthSuccess) {
      expect(currentState.user.phone, equals(phone));
      expect(currentState.user.accessToken, equals('test_access_token'));
      expect(currentState.user.refreshToken, equals('test_refresh_token'));
    }
  });

  test('Full login flow integration test - failure case', () async {
    // Arrange
    final phone = '0991234567';
    final password = 'wrong_password';

    when(mockHttpClient.post(
      Uri.parse('${dataSource.BaseURL}/api/auth/jwt/create/'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(
      '{"detail": "Invalid credentials"}',
      401,
    ));

    // Act & Assert
    // First, check that we're starting with AuthInitial
    expect(authBloc.state, isA<AuthInitial>());

    // Add the login event
    authBloc.add(LoginWithPhoneRequested(phone, password));

    // Use emitsInOrder to check state transitions
    await expectLater(
      authBloc.stream,
      emitsInOrder([
        isA<AuthLoading>(),
        isA<AuthFailure>(),
      ]),
    );

    // Additional verification after the state transitions
    final currentState = authBloc.state;
    expect(currentState, isA<AuthFailure>());
    if (currentState is AuthFailure) {
      expect(currentState.error, contains('Failed to login'));
    }
  });
}