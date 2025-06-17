import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // Here you would typically fetch data from repositories
      // For now, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeLoaded(
        featuredCourses: [
          _mockCourse('English Course', 'Brief Description', '\$39'),
          _mockCourse('French Course', 'Brief Description', '\$29'),
        ],
      ));
    } catch (e) {
      emit(HomeError(message: 'Failed to load home data'));
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