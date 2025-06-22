// // part of 'home_bloc.dart';

// // abstract class HomeState extends Equatable {
// //   const HomeState();

// //   @override
// //   List<Object> get props => [];
// // }

// // class HomeInitial extends HomeState {}

// // class HomeLoading extends HomeState {}

// // class HomeLoaded extends HomeState {
// //   final List<Map<String, dynamic>> featuredCourses;

// //   const HomeLoaded({required this.featuredCourses, required recommendedCourses});

// //   @override
// //   List<Object> get props => [featuredCourses];
// // }

// // class HomeError extends HomeState {
// //   final String message;

// //   const HomeError({required this.message});

// //   @override
// //   List<Object> get props => [message];
// // }
// // features/home/presentation/bloc/home_state.dart

// part of 'home_bloc.dart';

// abstract class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }

// class HomeInitial extends HomeState {}

// class HomeLoading extends HomeState {}

// class HomeLoaded extends HomeState {
//   final List<Course> recommendedCourses;
//   final List<Map<String, dynamic>> featuredCourses;

//   const HomeLoaded({
//     required this.recommendedCourses,
//     required this.featuredCourses,
//   });

//   @override
//   List<Object> get props => [recommendedCourses, featuredCourses];
// }

// class HomeError extends HomeState {
//   final String message;

//   const HomeError({required this.message});

//   @override
//   List<Object> get props => [message];
// }
// lib/features/home/presentation/bloc/home_state.dart

part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Course> recommendedCourses;
  final List<Map<String, dynamic>> featuredCourses;

  const HomeLoaded({
    required this.recommendedCourses,
    required this.featuredCourses,
  });

  @override
  List<Object> get props => [recommendedCourses, featuredCourses];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}