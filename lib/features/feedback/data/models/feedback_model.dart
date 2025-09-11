class FeedbackModel {
  final int id;
  final int scheduleslot;
  final int student;
  final int teacherRating;
  final int materialRating;
  final int facilitiesRating;
  final int appRating;
  final String notes;
  final String createdAt;
  final int totalRating;

  FeedbackModel({
    required this.id,
    required this.scheduleslot,
    required this.student,
    required this.teacherRating,
    required this.materialRating,
    required this.facilitiesRating,
    required this.appRating,
    required this.notes,
    required this.createdAt,
    required this.totalRating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      scheduleslot: json['scheduleslot'],
      student: json['student'],
      teacherRating: json['teacher_rating'],
      materialRating: json['material_rating'],
      facilitiesRating: json['facilities_rating'],
      appRating: json['app_rating'],
      notes: json['notes'],
      createdAt: json['created_at'],
      totalRating: json['total_rating'],
    );
  }

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