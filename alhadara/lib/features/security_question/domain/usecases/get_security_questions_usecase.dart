// features/security_question/domain/usecases/get_security_questions_usecase.dart
import '../repositories/security_question_repository.dart';
import '../entities/security_question_entity.dart';

class GetSecurityQuestionsUseCase {
  final SecurityQuestionRepository repository;

  GetSecurityQuestionsUseCase({required this.repository});

  Future<List<SecurityQuestionEntity>> call(String token) async {
    return await repository.getSecurityQuestions(token);
  }
}