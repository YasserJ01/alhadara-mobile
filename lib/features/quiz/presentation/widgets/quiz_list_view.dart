import 'package:flutter/material.dart';

import '../../domain/entities/quiz_entity.dart';
import 'quiz_card.dart';

class QuizListView extends StatelessWidget {
  final List<QuizEntity> quizzes;

  const QuizListView({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return QuizCard(quiz: quiz);
        },
      ),
    );
  }
}