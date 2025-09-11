part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class TeacherRatingChanged extends FeedbackEvent {
  final int rating;
  const TeacherRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class MaterialRatingChanged extends FeedbackEvent {
  final int rating;
  const MaterialRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class FacilitiesRatingChanged extends FeedbackEvent {
  final int rating;
  const FacilitiesRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class AppRatingChanged extends FeedbackEvent {
  final int rating;
  const AppRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class NotesChanged extends FeedbackEvent {
  final String notes;
  const NotesChanged(this.notes);

  @override
  List<Object> get props => [notes];
}

class SubmitFeedback extends FeedbackEvent {
  final int scheduleSlotId;
  final int studentId;
  
  const SubmitFeedback({
    required this.scheduleSlotId,
    required this.studentId,
  });

  @override
  List<Object> get props => [scheduleSlotId, studentId];
}