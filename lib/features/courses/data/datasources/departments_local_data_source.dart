// lib/features/courses/data/datasources/departments_local_data_source.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/department_model.dart';

abstract class DepartmentsLocalDataSource {
  Future<List<DepartmentModel>> getCachedDepartments();
  Future<void> cacheDepartments(List<DepartmentModel> departments);
  Future<void> clearDepartmentsCache();
  Future<bool> hasCachedDepartments();
  Future<DateTime?> getLastCacheTime();
  Future<void> setLastCacheTime(DateTime time);
}

class DepartmentsLocalDataSourceImpl implements DepartmentsLocalDataSource {
  static const String _departmentsBoxName = 'departments_box';
  static const String _cacheTimeBoxName = 'cache_time_box';
  static const String _departmentsKey = 'cached_departments';
  static const String _lastCacheTimeKey = 'last_cache_time';

  late Box<List<DepartmentModel>> _departmentsBox;
  late Box<DateTime> _cacheTimeBox;

  DepartmentsLocalDataSourceImpl() {
    _initializeBoxes();
  }

  Future<void> _initializeBoxes() async {
    try {
      _departmentsBox = await Hive.openBox<List<DepartmentModel>>(_departmentsBoxName);
      _cacheTimeBox = await Hive.openBox<DateTime>(_cacheTimeBoxName);
    } catch (e) {
      print('Error initializing Hive boxes: $e');
      rethrow;
    }
  }

  @override
  Future<List<DepartmentModel>> getCachedDepartments() async {
    try {
      await _initializeBoxes();
      final cachedDepartments = _departmentsBox.get(_departmentsKey);
      return cachedDepartments ?? [];
    } catch (e) {
      print('Error getting cached departments: $e');
      return [];
    }
  }

  @override
  Future<void> cacheDepartments(List<DepartmentModel> departments) async {
    try {
      await _initializeBoxes();
      await _departmentsBox.put(_departmentsKey, departments);
      await setLastCacheTime(DateTime.now());
      print('Successfully cached ${departments.length} departments');
    } catch (e) {
      print('Error caching departments: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearDepartmentsCache() async {
    try {
      await _initializeBoxes();
      await _departmentsBox.delete(_departmentsKey);
      await _cacheTimeBox.delete(_lastCacheTimeKey);
      print('Departments cache cleared');
    } catch (e) {
      print('Error clearing departments cache: $e');
      rethrow;
    }
  }

  @override
  Future<bool> hasCachedDepartments() async {
    try {
      await _initializeBoxes();
      final cachedDepartments = _departmentsBox.get(_departmentsKey);
      return cachedDepartments != null && cachedDepartments.isNotEmpty;
    } catch (e) {
      print('Error checking cached departments: $e');
      return false;
    }
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    try {
      await _initializeBoxes();
      return _cacheTimeBox.get(_lastCacheTimeKey);
    } catch (e) {
      print('Error getting last cache time: $e');
      return null;
    }
  }

  @override
  Future<void> setLastCacheTime(DateTime time) async {
    try {
      await _initializeBoxes();
      await _cacheTimeBox.put(_lastCacheTimeKey, time);
    } catch (e) {
      print('Error setting last cache time: $e');
      rethrow;
    }
  }
}