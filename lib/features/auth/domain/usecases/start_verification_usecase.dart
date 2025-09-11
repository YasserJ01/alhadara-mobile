// domain/usecases/start_verification_usecase.dart
import '../../../../errors/expections.dart';
import '../entities/verification_entities.dart';
import '../repositories/auth_repository.dart';

class StartVerificationUseCase {
  final AuthRepository repository;

  StartVerificationUseCase({required this.repository});

  Future<VerificationResult> call(String phone) async {
    if (phone.trim().isEmpty) {
      throw ValidationnException('Phone number cannot be empty');
    }

    return await repository.startVerification(phone);
  }
}