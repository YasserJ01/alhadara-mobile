import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/quiz_entity.dart';
import '../bloc/quiz_attempt/quiz_attempt_bloc.dart';
import '../bloc/quiz_attempt/quiz_attempt_event.dart';

void showQuizDetailsDialog(BuildContext parentContext, QuizEntity quiz) {
  // Get the bloc from the parent context before showing dialog
  final quizAttemptBloc = parentContext.read<QuizAttemptBloc>();

  showDialog(
    context: parentContext,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: Text(quiz.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description: ${quiz.description}'),
          const SizedBox(height: 8),
          Text('Time Limit: ${quiz.timeLimitMinutes} minutes'),
          const SizedBox(height: 8),
          Text('Passing Score: ${quiz.passingScore}'),
          const SizedBox(height: 8),
          Text('Questions: ${quiz.questionsCount}'),
          const SizedBox(height: 8),
          Text('Max Attempts: ${quiz.maxAttempts}'),
          const SizedBox(height: 8),
          Text('Your Attempts: ${quiz.userAttemptsCount}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            showQuizConfirmationDialog(parentContext, quiz, quizAttemptBloc);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
          ),
          child: const Text('SUBMIT'),
        ),
      ],
    ),
  );
}

void showQuizConfirmationDialog(
    BuildContext parentContext,
    QuizEntity quiz,
    QuizAttemptBloc quizAttemptBloc,
    ) {
  showDialog(
    context: parentContext,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Confirm Quiz Start'),
      content: const Text(
          'Are you sure you want to start this quiz? Once started, you cannot pause or restart.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            quizAttemptBloc.add(StartQuizAttemptEvent(quizId: quiz.id));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
          ),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}