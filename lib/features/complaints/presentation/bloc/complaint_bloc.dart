import '../../data/models/complaint_model.dart';
import '../../domain/entities/complaint_entity.dart';
import '../../domain/usecases/get_complaints.dart';
import '../../domain/usecases/submit_complaint.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final GetComplaints getComplaints;
  final SubmitComplaintUseCase submitComplaint;

  ComplaintBloc({
    required this.getComplaints,
    required this.submitComplaint,
  }) : super(ComplaintInitial()) {
    on<LoadComplaints>((event, emit) async {
      emit(ComplaintLoading());
      try {
        final complaints = await getComplaints();
        emit(ComplaintsLoaded(complaints));
      } catch (e) {
        emit(ComplaintError(e.toString()));
      }
    });

    on<SubmitComplaint>((event, emit) async {
      emit(ComplaintLoading());
      try {
        final complaint = Complaint(
          type: event.complaintData['type'],
          title: event.complaintData['title'],
          description: event.complaintData['description'],
          enrollment: event.complaintData['enrollment'],
          
        );
        
        final result = await submitComplaint(complaint);
        emit(ComplaintSubmitted(result));
      } catch (e) {
        emit(ComplaintError(e.toString()));
      }
    });
  }
}