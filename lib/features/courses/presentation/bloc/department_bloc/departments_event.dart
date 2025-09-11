part of 'departments_bloc.dart';

abstract class DepartmentsEvent extends Equatable {
  const DepartmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDepartments extends DepartmentsEvent {}

class RefreshDepartments extends DepartmentsEvent {}

class ConnectivityChanged extends DepartmentsEvent {
  final ConnectivityResult connectivityResult;

  const ConnectivityChanged(this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}

// abstract class DepartmentsEvent extends Equatable {
//   const DepartmentsEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class LoadDepartments extends DepartmentsEvent {}
//
