// auth/domain/repositories/auth_repository.dart

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithPhone(String phone, String password);
  Future<String> register(
      String firstName,
      String middleName,
      String lastName,
      String phone,
      String password,
      String confirmPassword,
      );
  Future<void> refreshToken();
  Future<void> logout();
  Future<bool> isLoggedIn();
}
// Future<UserRegisterEntity> register(String firstName,String middleName, String lastName,String phone, String password,String confirm_password); // New method
