part of 'complaint_bloc.dart';

abstract class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}

class ComplaintInitial extends ComplaintState {}

class ComplaintLoading extends ComplaintState {}

class ComplaintsLoaded extends ComplaintState {
  final List<ComplaintModel> complaints;

  const ComplaintsLoaded(this.complaints);

  @override
  List<Object> get props => [complaints];
}

class ComplaintSubmitted extends ComplaintState {
  final ComplaintModel complaint;

  const ComplaintSubmitted(this.complaint);

  @override
  List<Object> get props => [complaint];
}

class ComplaintError extends ComplaintState {
  final String message;

  const ComplaintError(this.message);

  @override
  List<Object> get props => [message];
}