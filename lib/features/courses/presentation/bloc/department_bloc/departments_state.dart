part of 'departments_bloc.dart';

abstract class DepartmentsState extends Equatable {
  const DepartmentsState();

  @override
  List<Object> get props => [];
}

class DepartmentsInitial extends DepartmentsState {}

class DepartmentsLoading extends DepartmentsState {}

class DepartmentsLoaded extends DepartmentsState {
  final List<Department> departments;

  const DepartmentsLoaded({required this.departments});

  @override
  List<Object> get props => [departments];
}

class DepartmentsError extends DepartmentsState {
  final String message;

  const DepartmentsError({required this.message});

  @override
  List<Object> get props => [message];
}

class DepartmentsEmpty extends DepartmentsState {
  final String message;

  const DepartmentsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}