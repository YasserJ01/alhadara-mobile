// lib/features/search/data/repositories/search_repository_impl.dart
import '../../../../errors/failures.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/entities/search_filters.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<SearchResult> searchCourses({
    required String query,
    SearchFilters? filters,
  }) async {
    try {
      final result = await remoteDataSource.searchCourses(
        query: query,
        filters: filters,
      );
      return result;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure();
    }
  }
}