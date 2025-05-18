import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project2/features/courses/domain/entites/course_types.dart';
import 'package:project2/features/courses/domain/usecases/get_departments.dart';
import '../../../../../errors/failures.dart';

part 'course_types_event.dart';
part 'course_types_state.dart';

class CourseTypesBloc extends Bloc<CourseTypesEvent, CourseTypesState> {
  final GetCourseTypes getCourseTypes;

  CourseTypesBloc({required this.getCourseTypes})
      : super(CourseTypesInitial()) {
    on<LoadCourseTypes>(_onLoadCourseTypes);
  }

  Future<void> _onLoadCourseTypes(
      LoadCourseTypes event,
      Emitter<CourseTypesState> emit,
      ) async {
    emit(CourseTypesLoading());
    try {
      final courseTypes = await getCourseTypes(event.department);
      if (courseTypes.isEmpty) {
        emit(const CourseTypesEmpty(message: 'No course types available for this department'));
      } else {
        emit(CourseTypesLoaded(courseTypes: courseTypes));
      }
    } on DataFormatFailure catch (_) {
      emit(const CourseTypesError(message: 'Data format error'));
    } on ServerFailure catch (_) {
      emit(const CourseTypesError(message: 'Server error - please try again'));
    } catch (e) {
      emit(const CourseTypesError(message: 'Unexpected error occurred'));
    }
  }
}
