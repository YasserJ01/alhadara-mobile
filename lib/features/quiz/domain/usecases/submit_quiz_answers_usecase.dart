import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/quiz_answer_entity.dart';
import '../repositories/quiz_repository.dart';

class SubmitQuizAnswersUseCase {
  final QuizRepository repository;

  SubmitQuizAnswersUseCase({required this.repository});

  Future<List<QuizAnswer>> call({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    return await repository.submitAnswers(
      attemptId: attemptId,
      answers: answers,
    );
  }
}