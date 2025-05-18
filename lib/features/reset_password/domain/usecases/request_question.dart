import 'package:project2/features/reset_password/data/models/security_question_model.dart';
import 'package:project2/features/reset_password/domain/repositories/reset_passwor_repository.dart';

class RequestSecurityQuestionUseCase {
  final PasswordResetRepository repository;

  RequestSecurityQuestionUseCase(this.repository);

  Future<List<SecurityQuestion>?> call(String phoneNumber) {
    return repository.requestSecurityQuestion(phoneNumber);
  }
}

class ValidateSecurityAnswerUseCase {
  final PasswordResetRepository repository;

  ValidateSecurityAnswerUseCase(this.repository);

  Future<ResetToken> call({
    required String phoneNumber,
    required int questionId,
    required String answer,
  }) {
    return repository.validateSecurityAnswer(
      phoneNumber: phoneNumber,
      questionId: questionId,
      answer: answer,
    );
  }
}

class ConfirmPasswordResetUseCase {
  final PasswordResetRepository repository;

  ConfirmPasswordResetUseCase(this.repository);

  Future<void> call({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repository.confirmPasswordReset(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
