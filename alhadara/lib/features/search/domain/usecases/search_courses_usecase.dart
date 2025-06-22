// lib/features/search/domain/usecases/search_courses_usecase.dart
import '../../../../errors/failures.dart';
import '../entities/search_result.dart';
import '../entities/search_filters.dart';
import '../repositories/search_repository.dart';

class SearchCoursesUseCase {
  final SearchRepository repository;

  SearchCoursesUseCase(this.repository);

  Future<SearchResult> call({
    required String query,
    SearchFilters? filters,
  }) async {
    if (query.trim().isEmpty) {
      throw NoDataFailure();
    }

    return await repository.searchCourses(
      query: query,
      filters: filters,
    );
  }
}