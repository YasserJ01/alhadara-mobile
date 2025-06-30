// import 'package:equatable/equatable.dart';

// abstract class EnrollmentEvent extends Equatable {
//   const EnrollmentEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchEnrollments extends EnrollmentEvent {}
part of 'enrollment_bloc.dart';


abstract class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class FetchEnrollments extends EnrollmentEvent {}

class SubmitPayment extends EnrollmentEvent {
  final int enrollmentId;
  final double amount;

  const SubmitPayment({required this.enrollmentId, required this.amount});

  @override
  List<Object> get props => [enrollmentId, amount];
}

class FetchEnrollmentDetails extends EnrollmentEvent {
  final int enrollmentId;

  const FetchEnrollmentDetails(this.enrollmentId);

  @override
  List<Object> get props => [enrollmentId];
}