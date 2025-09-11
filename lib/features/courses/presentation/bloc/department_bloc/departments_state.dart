part of 'departments_bloc.dart';
enum DepartmentsErrorType {
  network,
  server,
  cache,
  dataFormat,
  unknown,
}

abstract class DepartmentsState extends Equatable {
  const DepartmentsState();

  @override
  List<Object?> get props => [];
}

class DepartmentsInitial extends DepartmentsState {}

class DepartmentsLoading extends DepartmentsState {}

class DepartmentsLoaded extends DepartmentsState {
  final List<Department> departments;
  final bool isOffline;
  final DateTime? lastUpdated;

  const DepartmentsLoaded({
    required this.departments,
    this.isOffline = false,
    this.lastUpdated,
  });

  @override
  List<Object?> get props => [departments, isOffline, lastUpdated];

  DepartmentsLoaded copyWith({
    List<Department>? departments,
    bool? isOffline,
    DateTime? lastUpdated,
  }) {
    return DepartmentsLoaded(
      departments: departments ?? this.departments,
      isOffline: isOffline ?? this.isOffline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class DepartmentsError extends DepartmentsState {
  final String message;
  final bool isOffline;
  final DepartmentsErrorType errorType;

  const DepartmentsError({
    required this.message,
    this.isOffline = false,
    this.errorType = DepartmentsErrorType.unknown,
  });

  @override
  List<Object> get props => [message, isOffline, errorType];
}

class DepartmentsEmpty extends DepartmentsState {
  final String message;
  final bool isOffline;

  const DepartmentsEmpty({
    required this.message,
    this.isOffline = false,
  });

  @override
  List<Object> get props => [message, isOffline];
}

// abstract class DepartmentsState extends Equatable {
//   const DepartmentsState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class DepartmentsInitial extends DepartmentsState {}
//
// class DepartmentsLoading extends DepartmentsState {}
//
// class DepartmentsLoaded extends DepartmentsState {
//   final List<Department> departments;
//
//   const DepartmentsLoaded({required this.departments});
//
//   @override
//   List<Object> get props => [departments];
// }
//
// class DepartmentsError extends DepartmentsState {
//   final String message;
//
//   const DepartmentsError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
//
// class DepartmentsEmpty extends DepartmentsState {
//   final String message;
//
//   const DepartmentsEmpty({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
