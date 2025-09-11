import '../../data/models/answer_model.dart';
import '../../data/models/exam_attempt_model.dart';

abstract class EntranceExamRepository {
  Future<StartExamResponse> startExamByQr(String qrCode);
  Future<ExamAttempt> getExamAttempt(int attemptId);
  Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request);
}