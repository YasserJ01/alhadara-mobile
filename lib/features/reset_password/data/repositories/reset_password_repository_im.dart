import 'package:project2/features/reset_password/data/datasources/reset_password_datasource.dart';
import 'package:project2/features/reset_password/data/models/security_question_model.dart';
import 'package:project2/features/reset_password/domain/repositories/reset_passwor_repository.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  final PasswordResetApi api;

  PasswordResetRepositoryImpl({required this.api});

  @override
  Future<List<SecurityQuestion>?> requestSecurityQuestion(String phoneNumber) {
    return api.requestSecurityQuestion(phoneNumber);
  }

  @override
  Future<ResetToken> validateSecurityAnswer({
    required String phoneNumber,
    required int questionId,
    required String answer,
  }) {
    return api.validateSecurityAnswer(
      phoneNumber: phoneNumber,
      questionId: questionId,
      answer: answer,
    );
  }
  @override
  Future<void> confirmPasswordReset({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    return api.confirmPasswordReset(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}