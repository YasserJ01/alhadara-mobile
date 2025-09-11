// features/security_question/domain/repositories/security_question_repository.dart
import '../entities/security_question_entity.dart';

abstract class SecurityQuestionRepository {
  Future<List<SecurityQuestionEntity>> getSecurityQuestions();
  // features/security_question/domain/repositories/security_question_repository.dart
  Future<void> submitSecurityAnswer({
    required int questionId,
    required String answer,
  });
}