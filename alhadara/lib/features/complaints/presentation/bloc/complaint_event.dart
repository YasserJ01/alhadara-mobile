part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class LoadComplaints extends ComplaintEvent {}

class SubmitComplaint extends ComplaintEvent {
  final Map<String, dynamic> complaintData;

  const SubmitComplaint({required this.complaintData});

  @override
  List<Object> get props => [complaintData];
}