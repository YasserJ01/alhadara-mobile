// features/security_question/data/repositories/security_question_repository_impl.dart
import '../../domain/repositories/security_question_repository.dart';
import '../datasources/security_question_remote_data_source.dart';
import '../../domain/entities/security_question_entity.dart';
import '../models/security_question_model.dart';

class SecurityQuestionRepositoryImpl implements SecurityQuestionRepository {
  final SecurityQuestionRemoteDataSource remoteDataSource;

  SecurityQuestionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SecurityQuestionEntity>> getSecurityQuestions() async {
    try {
      final questions = await remoteDataSource.getSecurityQuestions();
      return questions.map(_mapModelToEntity).toList();
    } catch (e) {
      throw Exception('Failed to load security questions: ${e.toString()}');
    }
  }

  SecurityQuestionEntity _mapModelToEntity(SecurityQuestionModel model) {
    return SecurityQuestionEntity(
      id: model.id,
      questionText: model.questionText,
      language: model.language,
    );
  }

  @override
  Future<void> submitSecurityAnswer({
    required int questionId,
    required String answer,
  }) async {
    try {
      await remoteDataSource.submitSecurityAnswer(
        questionId: questionId,
        answer: answer,
      );
    } catch (e) {
      throw Exception('Failed to submit security answer: ${e.toString()}');
    }
  }
}