// auth/domain/usecases/register_usecase.dart
import 'package:project2/features/auth/domain/entities/user_register_entity.dart';

import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<String> call(
    String firstName,
    String middleName,
    String lastName,
    String phone,
    String password,
    String confirm_password,
  ) {
    return repository.register(
      firstName,
      middleName,
      lastName,
      phone,
      password,
      confirm_password,
    );
  }
}
