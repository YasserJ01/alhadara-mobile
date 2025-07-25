// class ComplaintModel {
//   final int id;
//   final String type;
//   final String title;
//   final String description;
//   final String status;
//   final String priority;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int enrollment;
//   final String? resolutionNotes;
//   final DateTime? resolvedAt;
//   final Map<String, dynamic>? enrollmentDetails;

//   ComplaintModel({
//     required this.id,
//     required this.type,
//     required this.title,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.enrollment,
//     this.resolutionNotes,
//     this.resolvedAt,
//     this.enrollmentDetails,
//   });

//   factory ComplaintModel.fromJson(Map<String, dynamic> json) {
//     return ComplaintModel(
//       id: json['id'],
//       type: json['type'],
//       title: json['title'],
//       description: json['description'],
//       status: json['status'],
//       priority: json['priority'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       enrollment: json['enrollment'],
//       resolutionNotes: json['resolution_notes'],
//       resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
//       enrollmentDetails: json['enrollment_details'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'title': title,
//       'description': description,
//       'priority': priority,
//       'enrollment': enrollment,
//     };
//   }
// }
class ComplaintModel {
  final int id;
  final String type;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? enrollment;
  final Map<String, dynamic>? enrollmentDetails;
  final String? resolutionNotes;
  final DateTime? resolvedAt;

  ComplaintModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.enrollment,
    this.enrollmentDetails,
    this.resolutionNotes,
    this.resolvedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      enrollment: json['enrollment'],
      enrollmentDetails: json['enrollment_details'],
      resolutionNotes: json['resolution_notes'],
      resolvedAt: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
    );
  }
}