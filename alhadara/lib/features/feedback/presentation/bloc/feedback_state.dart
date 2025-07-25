part of 'feedback_bloc.dart';

class FeedbackState extends Equatable {
  final int teacherRating;
  final int materialRating;
  final int facilitiesRating;
  final int appRating;
  final String notes;
  final FormStatus status;

  const FeedbackState({
    this.teacherRating = 0,
    this.materialRating = 0,
    this.facilitiesRating = 0,
    this.appRating = 0,
    this.notes = '',
    this.status = FormStatus.initial,
  });

  FeedbackState copyWith({
    int? teacherRating,
    int? materialRating,
    int? facilitiesRating,
    int? appRating,
    String? notes,
    FormStatus? status,
  }) {
    return FeedbackState(
      teacherRating: teacherRating ?? this.teacherRating,
      materialRating: materialRating ?? this.materialRating,
      facilitiesRating: facilitiesRating ?? this.facilitiesRating,
      appRating: appRating ?? this.appRating,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        teacherRating,
        materialRating,
        facilitiesRating,
        appRating,
        notes,
        status,
      ];
}

enum FormStatus { initial, loading, success, failure }
