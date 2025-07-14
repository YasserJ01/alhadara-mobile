import 'package:flutter/material.dart';

import '../../../domain/entities/quiz_question_entity.dart';

class QuestionCard extends StatelessWidget {
  final QuizQuestionItemEntity question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '${question.order}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Type: ${question.questionType.replaceAll('_', ' ').toUpperCase()} | Points: ${question.points}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...question.choices.map((choice) => RadioListTile<int>(
              title: Text(choice.text),
              value: choice.order,
              groupValue: selectedAnswer,
              onChanged: (value) => onAnswerSelected(value!),
              activeColor: Colors.blue.shade600,
            )),
          ],
        ),
      ),
    );
  }
}