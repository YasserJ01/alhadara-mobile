class TeacherHomeworkModel {
  final int id;
  final String title;
  final String description;
  final String formLink;
  final DateTime deadline;
  final int lesson;
  final int maxScore;
  final bool isMandatory;

  TeacherHomeworkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.formLink,
    required this.deadline,
    required this.lesson,
    required this.maxScore,
    required this.isMandatory,
  });

  factory TeacherHomeworkModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeworkModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      formLink: json['form_link'],
      deadline: DateTime.parse(json['deadline']),
      lesson: json['lesson'],
      maxScore: json['max_score'],
      isMandatory: json['is_mandatory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'form_link': formLink,
      'deadline': deadline.toIso8601String(),
      'lesson': lesson,
      'max_score': maxScore,
      'is_mandatory': isMandatory,
    };
  }
}
