// lib/features/search/data/datasources/search_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../errors/failures.dart';
import '../models/search_result_model.dart';
import '../../domain/entities/search_filters.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResultModel> searchCourses({
    required String query,
    SearchFilters? filters,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'http://10.0.2.2:8000/api/courses/search/';

  SearchRemoteDataSourceImpl(this.client);

  @override
  Future<SearchResultModel> searchCourses({
    required String query,
    SearchFilters? filters,
  }) async {
    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {
        'search': query,
        ...?filters?.toQueryParams(),
      };

      // Build URI with query parameters
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      // Make the HTTP request
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SearchResultModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw NoDataFailure();
      } else if (response.statusCode >= 500) {
        throw ServerFailure();
      } else {
        throw HttpFailure();
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure();
    }
  }
}