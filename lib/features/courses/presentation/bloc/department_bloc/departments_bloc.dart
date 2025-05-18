import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/entites/department.dart';
import '../../../domain/usecases/get_departments.dart';

part 'departments_event.dart';
part 'departments_state.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final GetDepartments getDepartments;

  DepartmentsBloc({required this.getDepartments})
      : super(DepartmentsInitial()) {
    on<LoadDepartments>(_onLoadDepartments);
  }

 Future<void> _onLoadDepartments(
  LoadDepartments event,
  Emitter<DepartmentsState> emit,
) async {
  emit(DepartmentsLoading());
  try {
    final departments = await getDepartments(NoParams());
    if (departments.isEmpty) {
      emit(const DepartmentsEmpty(message: 'No Departments available'));
    } else {
      emit(DepartmentsLoaded(departments: departments));
    }
  } on DataFormatFailure catch (_) {
    emit(DepartmentsError(message: 'Data format error'));
  } on ServerFailure catch (_) {
    emit(DepartmentsError(message: 'Server error - please try again'));
  } catch (e) {
    emit(DepartmentsError(message: 'Unexpected error occurred'));
  }
}
}
