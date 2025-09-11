import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/repositories/entrance_exam_repository.dart';
import '../datasources/entrance_exam_remote_data_source.dart';
import '../models/answer_model.dart';
import '../models/exam_attempt_model.dart';

class EntranceExamRepositoryImpl implements EntranceExamRepository {
  final EntranceExamRemoteDataSource remoteDataSource;

  EntranceExamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<StartExamResponse> startExamByQr(String qrCode) async {
    try {
      return await remoteDataSource.startExamByQr(qrCode);
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException catch (e) {
      throw NotFoundFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }

  @override
  Future<ExamAttempt> getExamAttempt(int attemptId) async {
    try {
      return await remoteDataSource.getExamAttempt(attemptId);
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException catch (e) {
      throw NotFoundFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }

  @override
  Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request) async {
    try {
      await remoteDataSource.submitMcqAnswers(attemptId, request);
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException catch (e) {
      throw NotFoundFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }
}