import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project2/features/courses/domain/entites/course.dart';
import 'package:project2/features/courses/domain/entites/course_types.dart';

import '../../../../core/cache/cache_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/entites/course_schedule.dart';
import '../../domain/entites/department.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_data_source.dart';
import '../datasources/departments_local_data_source.dart';
//data/repositories
class DepartmentRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource remoteDataSource;
  final DepartmentsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final CacheManager cacheManager;

  DepartmentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.cacheManager,
  });
  @override
  Future<List<Department>> getDepartments() async {
    print('=== Starting getDepartments ===');

    try {
      // Check network connectivity
      final bool isConnected = await networkInfo.hasInternetAccess;
      print('Network status: ${isConnected ? 'Connected' : 'Offline'}');

      if (isConnected) {
        return await _getOnlineDepartments();
      } else {
        return await _getOfflineDepartments();
      }
    } catch (e) {
      print('Error in getDepartments: $e');
      // If any error occurs, try to return cached data as fallback
      return await _getFallbackDepartments();
    }
  }

  Future<List<Department>> _getOnlineDepartments() async {
    try {
      print('Attempting to fetch from remote...');

      // Check if cache is still valid to avoid unnecessary API calls
      final lastCacheTime = await localDataSource.getLastCacheTime();
      final isCacheValid = await cacheManager.isCacheValid(lastCacheTime);

      if (isCacheValid && await localDataSource.hasCachedDepartments()) {
        print('Cache is still valid, using cached data');
        final cachedModels = await localDataSource.getCachedDepartments();
        return cachedModels.map((model) => model.toEntity()).toList();
      }

      // Fetch fresh data from API
      final remoteModels = await remoteDataSource.getDepartments();
      print('Successfully fetched ${remoteModels.length} departments from remote');

      // Cache the fresh data
      await localDataSource.cacheDepartments(remoteModels);
      print('Data cached successfully');

      return remoteModels.map((model) => model.toEntity()).toList();

    } on NetworkFailure {
      print('Network failure, falling back to cached data');
      return await _getOfflineDepartments();
    } on ServerFailure {
      print('Server failure, falling back to cached data');
      return await _getOfflineDepartments();
    } catch (e) {
      print('Unexpected error during online fetch: $e');
      return await _getOfflineDepartments();
    }
  }

  Future<List<Department>> _getOfflineDepartments() async {
    try {
      print('Getting departments from local cache...');

      final hasCache = await localDataSource.hasCachedDepartments();
      if (!hasCache) {
        print('No cached data available');
        throw  CacheFailure();
      }

      final cachedModels = await localDataSource.getCachedDepartments();
      print('Retrieved ${cachedModels.length} departments from cache');

      final lastCacheTime = await localDataSource.getLastCacheTime();
      if (lastCacheTime != null) {
        final age = DateTime.now().difference(lastCacheTime);
        print('Cache age: ${age.inHours}h ${age.inMinutes % 60}m');
      }

      return cachedModels.map((model) => model.toEntity()).toList();

    } catch (e) {
      print('Error getting offline departments: $e');
      if (e is CacheFailure) rethrow;
      throw  CacheFailure();
    }
  }

  Future<List<Department>> _getFallbackDepartments() async {
    try {
      print('Attempting fallback to cached data...');
      return await _getOfflineDepartments();
    } catch (e) {
      print('Fallback failed: $e');
      throw ServerFailure();
    }
  }

  // Additional methods for cache management
  Future<void> refreshDepartments() async {
    try {
      print('Force refreshing departments...');
      final remoteModels = await remoteDataSource.getDepartments();
      await localDataSource.cacheDepartments(remoteModels);
      print('Departments refreshed successfully');
    } catch (e) {
      print('Failed to refresh departments: $e');
      rethrow;
    }
  }

  Future<void> clearCache() async {
    try {
      await localDataSource.clearDepartmentsCache();
      print('Departments cache cleared');
    } catch (e) {
      print('Failed to clear cache: $e');
      rethrow;
    }
  }

  Future<bool> hasCachedData() async {
    return await localDataSource.hasCachedDepartments();
  }

  Future<DateTime?> getLastUpdateTime() async {
    return await localDataSource.getLastCacheTime();
  }


  // @override
  // Future<List<Department>> getDepartments() async {
  //   try {
  //     final models = await remoteDataSource.getDepartments();
  //     print('Repository received models: $models'); // Debug
  //     return models.map((model) => model.toEntity()).toList();
  //   } on FormatException catch (e) {
  //     print('Repository format error: $e'); // Debug
  //     throw DataFormatFailure();
  //   } on HttpException catch (e) {
  //     print('Repository HTTP error: $e'); // Debug
  //     throw ServerFailure();
  //   } catch (e) {
  //     print('Repository unexpected error: $e'); // Debug
  //     throw ServerFailure();
  //   }
  // }

  @override
  Future<List<CourseTypes>> getCourseTypes(int department) async {
    try {
      final models = await remoteDataSource.getCourseTypes(department);
      print('Repository received models: $models'); // Debug
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e'); // Debug
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e'); // Debug
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e'); // Debug
      throw ServerFailure();
    }
  }

  @override
  Future<List<Course>> getCourses(int department, int courseType) async {
    try {
      final models = await remoteDataSource.getCourses(department, courseType);
      print('Repository received models: $models');
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseSchedule>> getCourseSchedule(int courseId) async {
    try {
      final models = await remoteDataSource.getCourseSchedule(courseId);
      print('Repository received models: $models'); // Debug
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e'); // Debug
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e'); // Debug
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e'); // Debug
      throw ServerFailure();
    }
  }
  @override
  Future<List<Course>> getRecommendedCourses() async {
    try {
      final models = await remoteDataSource.getRecommendedCourses();
      print('Repository received recommended courses: $models');
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }
  @override
  Future<List<Course>> getDealsCourses() async {
    try {
      final models = await remoteDataSource.getDealsCourses();
      print('Repository received deals courses: $models');
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }
}
