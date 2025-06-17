// features/courses/presentation/bloc/enrollment/enroll_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/usecases/enroll_in_course.dart';
import 'enroll_event.dart';
import 'enroll_state.dart';

class EnrollBloc extends Bloc<EnrollEvent, EnrollState> {
  final EnrollInCourse enrollInCourse;

  EnrollBloc({required this.enrollInCourse}) : super(EnrollInitial()) {
    on<EnrollInCourseEvent>(_onEnrollInCourse);
  }

  Future<void> _onEnrollInCourse(
      EnrollInCourseEvent event,
      Emitter<EnrollState> emit,
      ) async {
    emit(EnrollLoading());

    try {
      final enrollment = await enrollInCourse(
        courseId: event.courseId,
        scheduleSlotId: event.scheduleSlotId,
      );
      emit(EnrollSuccess(enrollment));
    } catch (failure) {
      String message = 'Failed to enroll in course';

      if (failure is ServerFailure) {
        message = 'Server error. Please try again later.';
      } else if (failure is HttpFailure) {
        message = 'Network error. Please check your connection.';
      } else if (failure is NoDataFailure) {
        message = 'No data available.';
      }

      emit(EnrollError(message));
    }
  }
}