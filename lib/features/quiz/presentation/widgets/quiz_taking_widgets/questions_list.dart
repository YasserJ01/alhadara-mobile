import 'package:flutter/material.dart';

import '../../../domain/entities/quiz_question_entity.dart';
import 'question_card.dart';

class QuestionsList extends StatelessWidget {
  final List<QuizQuestionItemEntity> questions;
  final Map<int, int> selectedAnswers;
  final Function(int, int) onAnswerSelected;

  const QuestionsList({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return QuestionCard(
          question: question,
          selectedAnswer: selectedAnswers[question.order],
          onAnswerSelected: (choiceOrder) {
            onAnswerSelected(question.order, choiceOrder);
          },
        );
      },
    );
  }
}