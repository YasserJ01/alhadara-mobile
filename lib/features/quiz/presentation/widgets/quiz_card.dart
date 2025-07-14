import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/quiz/presentation/widgets/quiz_dialogs.dart';

import '../../domain/entities/quiz_entity.dart';
import '../bloc/quiz_attempt/quiz_attempt_bloc.dart';
import '../bloc/quiz_attempt/quiz_attempt_state.dart';

class QuizCard extends StatelessWidget {
  final QuizEntity quiz;

  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              quiz.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            QuizAvailabilityIndicator(quiz: quiz),
            const SizedBox(height: 12),
            if (quiz.isActive && quiz.isAvailable) QuizActionButton(quiz: quiz),
          ],
        ),
      ),
    );
  }
}

class QuizAvailabilityIndicator extends StatelessWidget {
  final QuizEntity quiz;

  const QuizAvailabilityIndicator({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          quiz.isAvailable ? Icons.check_circle : Icons.cancel,
          color: quiz.isAvailable ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          quiz.availabilityMessage,
          style: TextStyle(
            color: quiz.isAvailable ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class QuizActionButton extends StatelessWidget {
  final QuizEntity quiz;

  const QuizActionButton({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<QuizAttemptBloc, QuizAttemptState>(
        builder: (context, attemptState) {
          return ElevatedButton(
            onPressed: attemptState is QuizAttemptLoading
                ? null
                : () {
                    // Pass the parent context (from build method)
                    showQuizDetailsDialog(context, quiz);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: attemptState is QuizAttemptLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Take Quiz'),
          );
        },
      ),
    );
  }
}
