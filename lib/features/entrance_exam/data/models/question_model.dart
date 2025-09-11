import 'package:equatable/equatable.dart';
import 'choice_model.dart';

class Question extends Equatable {
  final int id;
  final String text;
  final String questionType;
  final int points;
  final int order;
  final List<Choice> choices;

  const Question({
    required this.id,
    required this.text,
    required this.questionType,
    required this.points,
    required this.order,
    required this.choices,
  });

  @override
  List<Object> get props => [id, text, questionType, points, order, choices];
}