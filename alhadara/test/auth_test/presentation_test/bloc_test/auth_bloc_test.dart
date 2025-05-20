import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:alhadara/features/auth/domain/entities/user_entity.dart';
import 'package:alhadara/features/auth/domain/usecases/login_with_phone_usecase.dart';
import 'package:alhadara/features/auth/presentation/bloc/auth_bloc.dart';
// Import your app files

// Generate mock use case
@GenerateMocks([LoginWithPhoneUseCase])
import 'auth_bloc_test.mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockLoginWithPhoneUseCase mockLoginWithPhoneUseCase;

  setUp(() {
    mockLoginWithPhoneUseCase = MockLoginWithPhoneUseCase();
    authBloc = AuthBloc(loginWithPhoneUseCase: mockLoginWithPhoneUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, equals(AuthInitial()));
  });

  group('LoginWithPhoneRequested', () {
    final phone = '0991234567';
    final password = 'password123';
    final user = UserEntity(
      phone: phone,
      accessToken: 'test_access_token',
      refreshToken: 'test_refresh_token',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        when(mockLoginWithPhoneUseCase(phone, password))
            .thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginWithPhoneRequested(phone, password)),
      expect: () => [
        AuthLoading(),
        AuthSuccess(user),
      ],
      verify: (_) {
        verify(mockLoginWithPhoneUseCase(phone, password)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails',
      build: () {
        when(mockLoginWithPhoneUseCase(phone, password))
            .thenThrow(Exception('Failed to login'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginWithPhoneRequested(phone, password)),
      expect: () => [
        AuthLoading(),
        AuthFailure('Exception: Failed to login'),
      ],
      verify: (_) {
        verify(mockLoginWithPhoneUseCase(phone, password)).called(1);
      },
    );
  });
}