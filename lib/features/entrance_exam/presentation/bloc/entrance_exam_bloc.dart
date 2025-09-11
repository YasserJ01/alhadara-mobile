import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../data/models/answer_model.dart';
import '../../domain/repositories/entrance_exam_repository.dart';
import 'entrance_exam_event.dart';
import 'entrance_exam_state.dart';

class EntranceExamBloc extends Bloc<EntranceExamEvent, EntranceExamState> {
  final EntranceExamRepository repository;

  EntranceExamBloc({required this.repository}) : super(EntranceExamInitial()) {
    on<StartExamByQrEvent>(_onStartExamByQr);
    on<LoadExamAttemptEvent>(_onLoadExamAttempt);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<SubmitAnswersEvent>(_onSubmitAnswers);
    on<ResetExamEvent>(_onResetExam);
  }

  Future<void> _onStartExamByQr(
      StartExamByQrEvent event,
      Emitter<EntranceExamState> emit,
      ) async {
    emit(EntranceExamLoading());
    try {
      final response = await repository.startExamByQr(event.qrCode);
      emit(ExamStarted(response.id));
    } catch (failure) {
      emit(EntranceExamError(_mapFailureToMessage(failure)));
    }
  }

  Future<void> _onLoadExamAttempt(
      LoadExamAttemptEvent event,
      Emitter<EntranceExamState> emit,
      ) async {
    emit(EntranceExamLoading());
    try {
      final examAttempt = await repository.getExamAttempt(event.attemptId);
      emit(ExamLoaded(
        examAttempt: examAttempt,
        userAnswers: {},
      ));
    } catch (failure) {
      emit(EntranceExamError(_mapFailureToMessage(failure)));
    }
  }

  void _onAnswerQuestion(
      AnswerQuestionEvent event,
      Emitter<EntranceExamState> emit,
      ) {
    if (state is ExamLoaded) {
      final currentState = state as ExamLoaded;
      final updatedAnswers = Map<int, int>.from(currentState.userAnswers);
      updatedAnswers[event.questionId] = event.choiceOrder;

      emit(currentState.copyWith(userAnswers: updatedAnswers));
    }
  }

  Future<void> _onSubmitAnswers(
      SubmitAnswersEvent event,
      Emitter<EntranceExamState> emit,
      ) async {
    if (state is ExamLoaded) {
      final currentState = state as ExamLoaded;
      emit(EntranceExamLoading());

      try {
        final answers = currentState.userAnswers.entries.map((entry) {
          // Convert from 0-based order to 1-based choice_index
          return Answer(
            question: entry.key,
            choiceIndex: entry.value + 1,
          );
        }).toList();

        final request = SubmitAnswersRequest(answers: answers);
        await repository.submitMcqAnswers(event.attemptId, request);
        emit(ExamCompleted());
      } catch (failure) {
        emit(EntranceExamError(_mapFailureToMessage(failure)));
      }
    }
  }

  void _onResetExam(
      ResetExamEvent event,
      Emitter<EntranceExamState> emit,
      ) {
    emit(EntranceExamInitial());
  }

  String _mapFailureToMessage(dynamic failure) {
    print('🔍 Mapping failure: ${failure.runtimeType} - $failure');

    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'Network error: ${failure.message}';
    } else if (failure is NotFoundFailure) {
      return 'QR Code Error: ${failure.message}';
    } else if (failure is UnauthorizedFailure) {
      return 'Access denied. Please check your credentials.';
    } else if (failure is ApiException) {
      return 'API Error (${failure.statusCode}): ${failure.message}';
    } else {
      return 'Unexpected error: $failure';
    }
  }
}