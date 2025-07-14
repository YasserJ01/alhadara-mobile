// data/repositories/quiz_repository_impl.dart
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/entities/quiz_answer_entity.dart';
import '../../domain/entities/quiz_attempt_entity.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/entities/quiz_question_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_remote_datasource.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<QuizEntity>> getQuizzes(int scheduleSlotId) async {
    try {
      final quizModels = await remoteDataSource.getQuizzes(scheduleSlotId);
      return quizModels.map((model) => QuizEntity.fromModel(model)).toList();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<QuizAttemptEntity> startQuizAttempt(int quizId) async {
    try {
      final attemptModel = await remoteDataSource.startQuizAttempt(quizId);
      return QuizAttemptEntity.fromModel(attemptModel);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<QuizQuestionEntity> getQuizQuestions(int quizId) async {
    try {
      final questionsModel = await remoteDataSource.getQuizQuestions(quizId);
      return QuizQuestionEntity.fromModel(questionsModel);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<List<QuizAnswer>> submitAnswers({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final models = await remoteDataSource.submitAnswers(
        attemptId: attemptId,
        answers: answers,
      );
      return models.map((model) => model.toEntity()).toList();
    } on NotFoundException {
      throw NotFoundFailure('Quiz attempt not found');
    } on ServerException {
      throw ServerFailure();
    } on ApiException catch (e) {
      throw HttpFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

}