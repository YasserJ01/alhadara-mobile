import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/features/auth/domain/entities/user_entity.dart';
import 'package:project2/features/auth/domain/repositories/auth_repository.dart';
import 'package:project2/features/auth/domain/usecases/login_with_phone_usecase.dart';
// Import your app files

// Generate mock repository
@GenerateMocks([AuthRepository])
import 'login_with_phone_usecase_test.mocks.dart';

void main() {
  late LoginWithPhoneUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginWithPhoneUseCase(mockRepository);
  });

  group('call', () {
    final phone = '0991234567';
    final password = 'password123';
    final expectedUser = UserEntity(
      phone: phone,
      accessToken: 'test_access_token',
      refreshToken: 'test_refresh_token',
    );

    test('should forward the call to the repository', () async {
      // Arrange
      when(mockRepository.loginWithPhone(phone, password))
          .thenAnswer((_) async => expectedUser);

      // Act
      final result = await useCase(phone, password);

      // Assert
      expect(result, equals(expectedUser));
      verify(mockRepository.loginWithPhone(phone, password));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
