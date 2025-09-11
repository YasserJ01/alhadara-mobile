class Complaint {
  final String type;
  final String title;
  final String description;
  // final String priority;
  final int? enrollment;

  Complaint({
    required this.type,
    required this.title,
    required this.description,
    // required this.priority,
    required this.enrollment,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'description': description,
      // 'priority': priority,
      'enrollment': enrollment,
    };
  }
}