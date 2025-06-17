// features/courses/presentation/bloc/enrollment/enroll_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/enrollment.dart';

abstract class EnrollState extends Equatable {
  const EnrollState();

  @override
  List<Object> get props => [];
}

class EnrollInitial extends EnrollState {}

class EnrollLoading extends EnrollState {}

class EnrollSuccess extends EnrollState {
  final EnrollEntity enrollment;

  const EnrollSuccess(this.enrollment);

  @override
  List<Object> get props => [enrollment];
}

class EnrollError extends EnrollState {
  final String message;

  const EnrollError(this.message);

  @override
  List<Object> get props => [message];
}
