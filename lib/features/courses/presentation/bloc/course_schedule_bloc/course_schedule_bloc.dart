import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/usecases/get_departments.dart';
import 'course_schedule_event.dart';
import 'course_schedule_state.dart';

class CourseScheduleBloc
    extends Bloc<CourseScheduleEvent, CourseScheduleState> {
  final GetCourseSchedule getCourseSchedule;

  CourseScheduleBloc({required this.getCourseSchedule})
      : super(CourseScheduleInitial()) {
    on<LoadCourseSchedule>(_onLoadCourseSchedule);
  }
  Future<void> _onLoadCourseSchedule(
    LoadCourseSchedule event,
    Emitter<CourseScheduleState> emit,
  ) async {
    emit(CourseScheduleLoading());
    try {
      final schedules = await getCourseSchedule(event.courseId);
      if (schedules.isEmpty) {
        emit(const CourseScheduleEmpty(
            message: 'No schedule available for this course'));
      } else {
        emit(CourseScheduleLoaded(schedules));
        // schedules
      }
    } on DataFormatFailure catch (_) {
      emit(const CourseScheduleError('Data format error'));
    } on ServerFailure catch (_) {
      emit(const CourseScheduleError('Server error - please try again'));
    } catch (e) {
      emit(const CourseScheduleError('Unexpected error occurred'));
    }
  }
}
