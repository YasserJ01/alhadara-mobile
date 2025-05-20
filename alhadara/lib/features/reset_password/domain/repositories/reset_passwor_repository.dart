import 'package:alhadara/features/reset_password/data/models/security_question_model.dart';

abstract class PasswordResetRepository {
  Future<List<SecurityQuestion>?> requestSecurityQuestion(String phoneNumber);
  Future<ResetToken> validateSecurityAnswer({
    required String phoneNumber,
    required int questionId,
    required String answer,
  });
   Future<void> confirmPasswordReset({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}