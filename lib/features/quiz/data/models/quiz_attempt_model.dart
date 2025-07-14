// models/quiz_attempt_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'quiz_attempt_model.g.dart';

@JsonSerializable()
class QuizAttemptModel extends Equatable {
  final int id;
  final int quiz;
  @JsonKey(name: 'quiz_title')
  final String quizTitle;
  final int user;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'started_at')
  final String startedAt;
  @JsonKey(name: 'time_remaining')
  final int timeRemaining;

  const QuizAttemptModel({
    required this.id,
    required this.quiz,
    required this.quizTitle,
    required this.user,
    required this.userName,
    required this.startedAt,
    required this.timeRemaining,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAttemptModelToJson(this);

  @override
  List<Object?> get props =>
      [id, quiz, quizTitle, user, userName, startedAt, timeRemaining];
}