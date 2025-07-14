import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz_questions/quiz_questions_bloc.dart';
import '../../bloc/quiz_questions/quiz_questions_state.dart';
import '../../bloc/quiz_submission/quiz_submission_bloc.dart';
import '../../pages/quiz_results_page.dart';
import '../quiz_error_widget.dart';
import 'loading_widget.dart';
import 'quiz_active_content.dart';

class QuizTakingContent extends StatelessWidget {
  final int attemptId; // Add this

  const QuizTakingContent({
    super.key,
    required this.attemptId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuizQuestionsBloc, QuizQuestionsState>(
          listener: (context, state) {
            if (state is QuizQuestionsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
        ),
        BlocListener<QuizSubmissionBloc, QuizSubmissionState>(
          listener: (context, state) {
            if (state is QuizSubmissionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is QuizSubmissionSuccess) {
              // Handle successful submission
              final totalPoints = state.answers
                  .fold(0, (sum, answer) => sum + answer.pointsEarned);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizResultsPage(
                    answers: state.answers,
                    totalPoints: totalPoints,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<QuizQuestionsBloc, QuizQuestionsState>(
        builder: (context, state) {
          if (state is QuizQuestionsLoading) {
            return const LoadingWidget();
          }

          if (state is QuizQuestionsLoaded) {
            return QuizActiveContent(
              questions: state.questions,
              attemptId: attemptId,
            );
          }

          if (state is QuizQuestionsError) {
            return QuizErrorWidget(message: state.message);
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
