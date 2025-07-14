// domain/usecases/get_quizzes_usecase.dart
import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';

class GetQuizzesUseCase {
  final QuizRepository repository;

  GetQuizzesUseCase({required this.repository});

  Future<List<QuizEntity>> call(int scheduleSlotId) async {
    return await repository.getQuizzes(scheduleSlotId);
  }
}