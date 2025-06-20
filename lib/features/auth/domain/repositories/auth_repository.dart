// auth/domain/repositories/auth_repository.dart

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithPhone(String phone, String password);
  Future<String> register(  // Return String (token)
      String firstName,
      String middleName,
      String lastName,
      String phone,
      String password,
      String confirmPassword
      );
  // Future<UserRegisterEntity> register(String firstName,String middleName, String lastName,String phone, String password,String confirm_password); // New method
}
