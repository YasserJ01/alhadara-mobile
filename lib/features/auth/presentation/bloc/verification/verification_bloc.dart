// presentation/bloc/verification_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/expections.dart';
import '../../../domain/usecases/start_verification_usecase.dart';
import '../../../domain/usecases/submit_verification_usecase.dart';
import 'verification_event.dart';
import 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final StartVerificationUseCase startVerificationUseCase;
  final SubmitVerificationUseCase submitVerificationUseCase;

  String? _currentToken;

  VerificationBloc({
    required this.startVerificationUseCase,
    required this.submitVerificationUseCase,
  }) : super(VerificationInitial()) {
    on<StartVerificationRequested>(_onStartVerificationRequested);
    on<SubmitVerificationRequested>(_onSubmitVerificationRequested);
    on<VerificationReset>(_onVerificationReset);
  }

  Future<void> _onStartVerificationRequested(
    StartVerificationRequested event,
    Emitter<VerificationState> emit,
  ) async {
    emit(VerificationLoading());

    try {
      final result = await startVerificationUseCase(event.phone);
      _currentToken = result.token;
      emit(VerificationStarted(result: result));
    } on ValidationnException catch (e) {
      emit(VerificationError(message: e.toString()));
    } on ValidationException catch (e) {
      emit(VerificationError(message: 'Validation error: ${e.errors}'));
    } on ApiException catch (e) {
      emit(VerificationError(message: e.message));
    } on ServerException catch (e) {
      emit(VerificationError(message: e.message));
    } on UnauthorizedException catch (e) {
      emit(VerificationError(message: e.message));
    } on NotFoundException catch (e) {
      emit(VerificationError(message: e.message));
    } catch (e) {
      emit(VerificationError(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onSubmitVerificationRequested(
    SubmitVerificationRequested event,
    Emitter<VerificationState> emit,
  ) async {
    if (_currentToken == null) {
      emit(VerificationError(message: 'No verification session found'));
      return;
    }

    emit(VerificationSubmitting(token: _currentToken!));

    try {
      await submitVerificationUseCase(_currentToken!, event.pin);
      emit(VerificationSuccess());
    } on ValidationnException catch (e) {
      emit(VerificationError(message: e.toString()));
    } on ValidationException catch (e) {
      emit(VerificationError(message: 'Invalid verification code'));
    } on ApiException catch (e) {
      if (e.statusCode == 400) {
        emit(VerificationError(message: 'Invalid verification code'));
      } else {
        emit(VerificationError(message: e.message));
      }
    } on ServerException catch (e) {
      emit(VerificationError(message: e.message));
    } on UnauthorizedException catch (e) {
      emit(VerificationError(message: e.message));
    } on NotFoundException catch (e) {
      emit(VerificationError(message: e.message));
    } catch (e) {
      emit(VerificationError(message: 'An unexpected error occurred'));
    }
  }

  void _onVerificationReset(
    VerificationReset event,
    Emitter<VerificationState> emit,
  ) {
    _currentToken = null;
    emit(VerificationInitial());
  }
}
