// domain/usecases/submit_verification_usecase.dart

import '../../../../errors/expections.dart';
import '../repositories/auth_repository.dart';

class SubmitVerificationUseCase {
  final AuthRepository repository;

  SubmitVerificationUseCase({required this.repository});

  Future<void> call(String token, String pin) async {
    if (token.trim().isEmpty) {
      throw ValidationnException('Token cannot be empty');
    }

    if (pin.trim().isEmpty) {
      throw ValidationnException('PIN cannot be empty');
    }

    if (pin.length != 6) {
      throw ValidationnException('PIN must be 6 digits');
    }

    return await repository.submitVerification(token, pin);
  }
}
