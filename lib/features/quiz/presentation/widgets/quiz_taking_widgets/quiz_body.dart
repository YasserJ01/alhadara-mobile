import 'package:flutter/material.dart';

import '../../../domain/entities/quiz_question_entity.dart';
import 'questions_list.dart';
import 'quiz_header.dart';
import 'submit_button.dart';

class QuizBody extends StatelessWidget {
  final QuizQuestionEntity questions;
  final Map<int, int> selectedAnswers;
  final bool isQuizActive;
  final Function(int, int) onAnswerSelected;
  final VoidCallback? onSubmitQuiz;

  const QuizBody({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.isQuizActive,
    required this.onAnswerSelected,
    this.onSubmitQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Column(
        children: [
          QuizHeader(questions: questions),
          Expanded(
            child: QuestionsList(
              questions: questions.questions,
              selectedAnswers: selectedAnswers,
              onAnswerSelected: onAnswerSelected,
            ),
          ),
          SubmitButton(
            isActive: isQuizActive,
            onSubmit: onSubmitQuiz,
            answeredCount: selectedAnswers.length,
            totalQuestions: questions.questions.length,
          ),
        ],
      ),
    );
  }
}