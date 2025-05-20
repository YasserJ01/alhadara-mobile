// // features/courses/presentation/bloc/courses_bloc/courses_bloc.dart
// import 'package:alhadara/features/courses/domain/entites/course.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';import 'package:alhadara/features/courses/domain/usecases/get_courses.dart';

// part 'courses_event.dart';
// part 'courses_state.dart';

// class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
//   final GetCourses getCourses;

//   CoursesBloc({required this.getCourses}) : super(CoursesInitial()) {
//     on<LoadCourses>((event, emit) async {
//       emit(CoursesLoading());
//       final result = await getCourses(
//           Params(department: event.department, courseType: event.courseType));
//       result.fold(
//         (failure) => emit(CoursesError(message: failure.toString())),
//         (courses) => courses.isEmpty
//             ? emit(CoursesEmpty(message: 'No courses found'))
//             : emit(CoursesLoaded(courses: courses)),
//       );
//     });
//   }
// }
// features/courses/presentation/bloc/courses_bloc/courses_bloc.dart
import 'package:alhadara/errors/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/courses/domain/entites/course.dart';
import 'package:alhadara/features/courses/domain/usecases/get_courses.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCourses getCourses;

  CoursesBloc({required this.getCourses}) : super(CoursesInitial()) {
    on<LoadCourses>((event, emit) async {
  emit(CoursesLoading());
  try {
    final courses = await getCourses(
      CourseParams(
        department: event.department,
        courseType: event.courseType,
      ),
    );
    // Filter courses by category
    final filteredCourses = courses.where((course) => 
      course.category.toLowerCase() == event.category.toLowerCase()
    ).toList();
    
    if (filteredCourses.isEmpty) {
      emit(CoursesEmpty(message: 'No ${event.category}s found'));
    } else {
      emit(CoursesLoaded(courses: filteredCourses));
    }
  } on Failure catch (e) {
    emit(CoursesError(message: e.toString()));
  } catch (e) {
    emit(CoursesError(message: 'An unexpected error occurred'));
  }
});
  }
}