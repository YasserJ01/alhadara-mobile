import '../repositories/auth_repository.dart';

class VerifyCaptchaUseCase {
  final AuthRepository repository;

  VerifyCaptchaUseCase(this.repository);

  Future<bool> execute(String key, String answer) async {
    return await repository.verifyCaptcha(key, answer);
  }
}