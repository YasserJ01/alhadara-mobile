// // import 'package:bloc/bloc.dart';
// // import 'package:equatable/equatable.dart';
// // part 'home_event.dart';
// // part 'home_state.dart';

// // class HomeBloc extends Bloc<HomeEvent, HomeState> {
// //   HomeBloc() : super(HomeInitial()) {
// //     on<LoadHomeData>(_onLoadHomeData);
// //   }

// //   Future<void> _onLoadHomeData(
// //     LoadHomeData event,
// //     Emitter<HomeState> emit,
// //   ) async {
// //     emit(HomeLoading());
// //     try {
// //       // Here you would typically fetch data from repositories
// //       // For now, we'll use mock data
// //       await Future.delayed(const Duration(seconds: 1));
// //       emit(HomeLoaded(
// //         featuredCourses: [
// //           _mockCourse('English Course', 'Brief Description', '\$39'),
// //           _mockCourse('French Course', 'Brief Description', '\$29'),
// //         ],
// //       ));
// //     } catch (e) {
// //       emit(HomeError(message: 'Failed to load home data'));
// //     }
// //   }

// //   Map<String, dynamic> _mockCourse(String title, String description, String price) {
// //     return {
// //       'title': title,
// //       'description': description,
// //       'price': price,
// //     };
// //   }
// // }
// // features/home/presentation/bloc/home_bloc.dart

// import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:alhadara/features/courses/domain/entites/course.dart';
// import 'package:alhadara/features/courses/domain/usecases/get_recommended_courses.dart';
// import 'package:alhadara/errors/failures.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final GetRecommendedCourses getRecommendedCourses;

//   HomeBloc({required this.getRecommendedCourses}) : super(HomeInitial()) {
//     on<LoadHomeData>(_onLoadHomeData);
//   }

//   Future<void> _onLoadHomeData(
//     LoadHomeData event,
//     Emitter<HomeState> emit,
//   ) async {
//     emit(HomeLoading());
//     try {
//       final recommendedCoursesResult = await getRecommendedCourses(NoParams());
      
//       return recommendedCoursesResult.fold(
//         (failure) => emit(HomeError(message: _mapFailureToMessage(failure))),
//         (recommendedCourses) => emit(HomeLoaded(
//           recommendedCourses: recommendedCourses,
//           featuredCourses: [
//             // You can keep your mock featured courses or fetch real ones
//             _mockCourse('English Course', 'Brief Description', '\$39'),
//             _mockCourse('French Course', 'Brief Description', '\$29'),
//           ],
//         )),
//       );
//     } catch (e) {
//       emit(HomeError(message: 'Failed to load home data: ${e.toString()}'));
//     }
//   }

//   String _mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case ServerFailure:
//         return 'Server error';
//       case DataFormatFailure:
//         return 'Data format error';
//       default:
//         return 'Unexpected error';
//     }
//   }

//   Map<String, dynamic> _mockCourse(String title, String description, String price) {
//     return {
//       'title': title,
//       'description': description,
//       'price': price,
//     };
//   }
// }
// lib/features/home/presentation/bloc/home_bloc.dart

import 'package:alhadara/features/courses/domain/usecases/get_deals_courses.dart';
import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/courses/domain/entites/course.dart';
import 'package:alhadara/features/courses/domain/usecases/get_recommended_courses.dart';
import 'package:alhadara/errors/failures.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecommendedCourses getRecommendedCourses;
  final GetDealsCourses getDealsCourses;

  HomeBloc({required this.getRecommendedCourses,required this.getDealsCourses}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final recommendedCourses = await getRecommendedCourses(NoParams());
       final dealsCourses = await getDealsCourses(NoParams()); 
      emit(HomeLoaded(
        recommendedCourses: recommendedCourses,
         dealsCourses: dealsCourses,
        featuredCourses: [
          _mockCourse('English Course', 'Brief Description', '\$39'),
          _mockCourse('French Course', 'Brief Description', '\$29'),
        ],
      ));
    } on Failure catch (e) {
      emit(HomeError(message: _mapFailureToMessage(e)));
    } catch (e) {
      emit(HomeError(message: 'An unexpected error occurred'));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case DataFormatFailure:
        return 'Data format error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }

  Map<String, dynamic> _mockCourse(String title, String description, String price) {
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }
}