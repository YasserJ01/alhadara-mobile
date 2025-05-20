part of 'departments_bloc.dart';


abstract class DepartmentsEvent extends Equatable {
  const DepartmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadDepartments extends DepartmentsEvent {}