// auth/domain/repositories/auth_repository.dart

import '../entities/user_entity.dart';
import '../entities/verification_entities.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithPhone(String phone, String password);
  Future<String> register(
      String firstName,
      String middleName,
      String lastName,
      String phone,
      String password,
      String confirmPassword,
      String captchaKey,
      String captchaAnswer,
      );
  Future<bool> verifyCaptcha(String key, String answer);

  Future<void> refreshToken();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> getCurrentUser();
  Future<VerificationResult> startVerification(String phone);
  Future<void> submitVerification(String token, String pin);

}
// Future<UserRegisterEntity> register(String firstName,String middleName, String lastName,String phone, String password,String confirm_password); // New method
