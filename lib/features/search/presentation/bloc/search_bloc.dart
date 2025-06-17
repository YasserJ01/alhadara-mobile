// lib/features/search/presentation/bloc/search_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../errors/failures.dart';
import '../../domain/usecases/search_courses_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchCoursesUseCase searchCoursesUseCase;

  SearchBloc({
    required this.searchCoursesUseCase,
  }) : super(SearchInitial()) {
    on<SearchCoursesEvent>(_onSearchCourses);
    on<ClearSearchEvent>(_onClearSearch);
    on<UpdateFiltersEvent>(_onUpdateFilters);
  }

  Future<void> _onSearchCourses(
      SearchCoursesEvent event,
      Emitter<SearchState> emit,
      ) async {
    if (event.query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final result = await searchCoursesUseCase(
        query: event.query,
        filters: event.filters,
      );

      if (result.departments.isEmpty &&
          result.courseTypes.isEmpty &&
          result.courses.isEmpty) {
        emit(SearchEmpty(query: event.query));
      } else {
        emit(SearchLoaded(
          result: result,
          query: event.query,
          filters: event.filters,
        ));
      }
    } catch (e) {
      String errorMessage;
      if (e is ServerFailure) {
        errorMessage = 'Server error occurred. Please try again later.';
      } else if (e is HttpFailure) {
        errorMessage = 'Network error. Please check your connection.';
      } else if (e is NoDataFailure) {
        errorMessage = 'No data found for your search.';
      } else if (e is DataFormatFailure) {
        errorMessage = 'Data format error. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again.';
      }
      emit(SearchError(message: errorMessage));
    }
  }

  void _onClearSearch(
      ClearSearchEvent event,
      Emitter<SearchState> emit,
      ) {
    emit(SearchInitial());
  }

  void _onUpdateFilters(
      UpdateFiltersEvent event,
      Emitter<SearchState> emit,
      ) {
    // If we have a previous search loaded, re-search with new filters
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      add(SearchCoursesEvent(
        query: currentState.query,
        filters: event.filters,
      ));
    }
  }
}