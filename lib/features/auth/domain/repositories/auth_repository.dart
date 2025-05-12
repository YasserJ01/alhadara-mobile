// auth/domain/repositories/auth_repository.dart
import 'package:project2/features/auth/domain/entities/user_register_entity.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithPhone(String phone, String password);
  Future<UserRegisterEntity> register(String firstName,String middleName, String lastName,String phone, String password); // New method
}
