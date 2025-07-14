// domain/repositories/quiz_repository.dart
import '../../../../errors/failures.dart';
import '../entities/quiz_answer_entity.dart';
import '../entities/quiz_entity.dart';
import '../entities/quiz_attempt_entity.dart';
import '../entities/quiz_question_entity.dart';

abstract class QuizRepository {
  Future<List<QuizEntity>> getQuizzes(int scheduleSlotId);
  Future<QuizAttemptEntity> startQuizAttempt(int quizId);
  Future<QuizQuestionEntity> getQuizQuestions(int quizId);
  Future<List<QuizAnswer>> submitAnswers({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  });
}
