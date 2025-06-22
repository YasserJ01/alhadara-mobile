// lib/features/search/domain/repositories/search_repository.dart
import '../entities/search_filters.dart';
import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<SearchResult> searchCourses({
    required String query,
    SearchFilters? filters,
  });
}