import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/entites/department.dart';
import '../../../domain/usecases/get_departments.dart';

part 'departments_event.dart';
part 'departments_state.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final GetDepartments getDepartments;
  final NetworkInfo networkInfo;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  DepartmentsBloc({
    required this.getDepartments,
    required this.networkInfo,
  }) : super(DepartmentsInitial()) {
    on<LoadDepartments>(_onLoadDepartments);
    on<RefreshDepartments>(_onRefreshDepartments);
    on<ConnectivityChanged>(_onConnectivityChanged);

    _startConnectivityListener();
  }

  void _startConnectivityListener() {
    _connectivitySubscription = networkInfo.onConnectivityChanged.listen(
          (ConnectivityResult result) {
        add(ConnectivityChanged(result));
      },
    );
  }

  Future<void> _onLoadDepartments(
      LoadDepartments event,
      Emitter<DepartmentsState> emit,
      ) async {
    emit(DepartmentsLoading());
    await _fetchDepartments(emit, isRefresh: false);
  }

  Future<void> _onRefreshDepartments(
      RefreshDepartments event,
      Emitter<DepartmentsState> emit,
      ) async {
    // Don't emit loading for refresh to avoid UI flicker
    await _fetchDepartments(emit, isRefresh: true);
  }

  Future<void> _onConnectivityChanged(
      ConnectivityChanged event,
      Emitter<DepartmentsState> emit,
      ) async {
    final isConnected = await networkInfo.hasInternetAccess;
    print('Connectivity changed: ${event.connectivityResult} - Has internet: $isConnected');

    // Update the current state with connectivity info
    if (state is DepartmentsLoaded) {
      final currentState = state as DepartmentsLoaded;
      emit(currentState.copyWith(isOffline: !isConnected));
    } else if (state is DepartmentsError && isConnected) {
      // If we were in error state due to network issues, try to reload
      add(LoadDepartments());
    }
  }

  Future<void> _fetchDepartments(
      Emitter<DepartmentsState> emit,
      {required bool isRefresh}
      ) async {
    try {
      final isConnected = await networkInfo.hasInternetAccess;
      print('Fetching departments - Connected: $isConnected, Refresh: $isRefresh');

      final departments = await getDepartments(NoParams());

      if (departments.isEmpty) {
        emit(DepartmentsEmpty(
          message: isConnected
              ? 'No departments available'
              : 'No departments available offline',
          isOffline: !isConnected,
        ));
      } else {
        emit(DepartmentsLoaded(
          departments: departments,
          isOffline: !isConnected,
          lastUpdated: DateTime.now(),
        ));

        if (!isConnected && !isRefresh) {
          // Show a brief message that data is from cache
          print('Showing cached data - user is offline');
        }
      }
    } on NetworkFailure catch (e) {
      print('Network failure: ${e.message}');
      emit(DepartmentsError(
        message: 'No internet connection. Showing cached data if available.',
        isOffline: true,
        errorType: DepartmentsErrorType.network,
      ));
    } on CacheFailure catch (e) {
      print('Cache failure: $e');
      emit(DepartmentsError(
        message: 'No data available offline. Please connect to the internet.',
        isOffline: true,
        errorType: DepartmentsErrorType.cache,
      ));
    } on ServerFailure catch (e) {
      print('Server failure: $e');
      final isConnected = await networkInfo.hasInternetAccess;
      emit(DepartmentsError(
        message: isConnected
            ? 'Server error. Please try again.'
            : 'Server error. Showing cached data if available.',
        isOffline: !isConnected,
        errorType: DepartmentsErrorType.server,
      ));
    } on DataFormatFailure catch (e) {
      print('Data format failure: $e');
      emit(DepartmentsError(
        message: 'Data format error. Please contact support.',
        isOffline: false,
        errorType: DepartmentsErrorType.dataFormat,
      ));
    } catch (e) {
      print('Unexpected error: $e');
      final isConnected = await networkInfo.hasInternetAccess;
      emit(DepartmentsError(
        message: 'Unexpected error occurred. Please try again.',
        isOffline: !isConnected,
        errorType: DepartmentsErrorType.unknown,
      ));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}

// class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
//   final GetDepartments getDepartments;
//
//   DepartmentsBloc({required this.getDepartments})
//       : super(DepartmentsInitial()) {
//     on<LoadDepartments>(_onLoadDepartments);
//   }
//
//  Future<void> _onLoadDepartments(
//   LoadDepartments event,
//   Emitter<DepartmentsState> emit,
// ) async {
//   emit(DepartmentsLoading());
//   try {
//     final departments = await getDepartments(NoParams());
//     if (departments.isEmpty) {
//       emit(const DepartmentsEmpty(message: 'No Departments available'));
//     } else {
//       emit(DepartmentsLoaded(departments: departments));
//     }
//   } on DataFormatFailure catch (_) {
//     emit(DepartmentsError(message: 'Data format error'));
//   } on ServerFailure catch (_) {
//     emit(DepartmentsError(message: 'Server error - please try again'));
//   } catch (e) {
//     emit(DepartmentsError(message: 'Unexpected error occurred'));
//   }
// }
// }
