// features/security_question/domain/repositories/security_question_repository.dart
import '../entities/security_question_entity.dart';

abstract class SecurityQuestionRepository {
  Future<List<SecurityQuestionEntity>> getSecurityQuestions(String token);
  // features/security_question/domain/repositories/security_question_repository.dart
  Future<void> submitSecurityAnswer({
    required String token,
    required int questionId,
    required String answer,
  });
}