// domain/usecases/start_quiz_attempt_usecase.dart
import '../entities/quiz_attempt_entity.dart';
import '../repositories/quiz_repository.dart';

class StartQuizAttemptUseCase {
  final QuizRepository repository;

  StartQuizAttemptUseCase({required this.repository});

  Future<QuizAttemptEntity> call(int quizId) async {
    return await repository.startQuizAttempt(quizId);
  }
}