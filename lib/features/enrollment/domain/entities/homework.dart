// entities/homework.dart
import 'package:equatable/equatable.dart';

class Homework extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime deadline;
  final int maxScore;
  final bool isMandatory;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Homework({
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