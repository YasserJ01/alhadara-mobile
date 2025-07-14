// models/homework_model.dart
import 'package:equatable/equatable.dart';

class HomeworkModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime deadline;
  final int maxScore;
  final bool isMandatory;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HomeworkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.maxScore,
    required this.isMandatory,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      maxScore: json['max_score'] as int,
      isMandatory: json['is_mandatory'] as bool,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'max_score': maxScore,
      'is_mandatory': isMandatory,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
    id,
    title,
    description,
    deadline,
    maxScore,
    isMandatory,
    status,
    createdAt,
    updatedAt,
  ];
}
