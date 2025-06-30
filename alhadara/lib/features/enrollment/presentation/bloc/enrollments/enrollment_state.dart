part of 'enrollment_bloc.dart';

abstract class EnrollmentState extends Equatable {
  const EnrollmentState();

  @override
  List<Object> get props => [];
}

class EnrollmentInitial extends EnrollmentState {}

class EnrollmentLoading extends EnrollmentState {}

class EnrollmentLoaded extends EnrollmentState {
  final List<EnrollmentEntity> enrollments;

  const EnrollmentLoaded(this.enrollments);

  @override
  List<Object> get props => [enrollments];
}

class EnrollmentError extends EnrollmentState {
  final String message;

  const EnrollmentError(this.message);

  @override
  List<Object> get props => [message];
}

class PaymentSuccess extends EnrollmentState {
  final String message;

  const PaymentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EnrollmentDetailsLoaded extends EnrollmentState {
  final EnrollmentEntity enrollment;

  const EnrollmentDetailsLoaded(this.enrollment);

  @override
  List<Object> get props => [enrollment];
}
