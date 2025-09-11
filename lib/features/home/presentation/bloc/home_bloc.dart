import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../errors/failures.dart';
import '../../../courses/domain/entites/course.dart';
import '../../../courses/domain/usecases/get_deals_courses.dart';
import '../../../courses/domain/usecases/get_departments.dart';
import '../../../courses/domain/usecases/get_recommended_courses.dart';
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