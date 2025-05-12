// auth/domain/usecases/login_with_phone_usecase.dart
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithPhoneUseCase {
  final AuthRepository repository;

  LoginWithPhoneUseCase(this.repository);

  Future<UserEntity> call(String phone, String password) {
    return repository.loginWithPhone(phone, password);
  }
}