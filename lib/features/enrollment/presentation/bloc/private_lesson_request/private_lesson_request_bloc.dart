import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/private_lesson_request.dart';
import '../../../domain/usecases/create_private_lesson_request.dart';

part 'private_lesson_request_event.dart';
part 'private_lesson_request_state.dart';

class PrivateLessonRequestBloc
    extends Bloc<PrivateLessonRequestEvent, PrivateLessonRequestState> {
  final CreatePrivateLessonRequest createPrivateLessonRequest;

  PrivateLessonRequestBloc({required this.createPrivateLessonRequest})
      : super(const PrivateLessonRequestState()) {
    on<SubmitPrivateLessonRequest>(_onSubmitPrivateLessonRequest);
  }

  Future<void> _onSubmitPrivateLessonRequest(
    SubmitPrivateLessonRequest event,
    Emitter<PrivateLessonRequestState> emit,
  ) async {
    emit(state.copyWith(status: PrivateLessonRequestStatus.loading));

    try {
      final request = await createPrivateLessonRequest.call(
        scheduleSlot: event.scheduleSlot,
        preferredDate: event.preferredDate,
        preferredTimeFrom: event.preferredTimeFrom,
        preferredTimeTo: event.preferredTimeTo,
      );

      emit(state.copyWith(
        status: PrivateLessonRequestStatus.success,
        request: request,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PrivateLessonRequestStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}