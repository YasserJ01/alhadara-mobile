// domain/usecases/get_quiz_questions_usecase.dart
import '../entities/quiz_question_entity.dart';
import '../repositories/quiz_repository.dart';

class GetQuizQuestionsUseCase {
  final QuizRepository repository;

  GetQuizQuestionsUseCase({required this.repository});

  Future<QuizQuestionEntity> call(int quizId) async {
    return await repository.getQuizQuestions(quizId);
  }
}