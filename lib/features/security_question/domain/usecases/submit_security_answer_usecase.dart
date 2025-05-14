// features/security_question/domain/usecases/submit_security_answer_usecase.dart
import '../repositories/security_question_repository.dart';

class SubmitSecurityAnswerUseCase {
  final SecurityQuestionRepository repository;

  SubmitSecurityAnswerUseCase({required this.repository});

  Future<void> call({
    required String token,
    required int questionId,
    required String answer,
  }) async {
    return await repository.submitSecurityAnswer(
      token: token,
      questionId: questionId,
      answer: answer,
    );
  }
}