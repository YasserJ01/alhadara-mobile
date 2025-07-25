class FeedbackEntity {
  final int scheduleslot;
  final int student;
  final int teacherRating;
  final int materialRating;
  final int facilitiesRating;
  final int appRating;
  final String notes;

  FeedbackEntity({
    required this.scheduleslot,
    required this.student,
    required this.teacherRating,
    required this.materialRating,
    required this.facilitiesRating,
    required this.appRating,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'scheduleslot': scheduleslot,
      'student': student,
      'teacher_rating': teacherRating,
      'material_rating': materialRating,
      'facilities_rating': facilitiesRating,
      'app_rating': appRating,
      'notes': notes,
    };
  }
}