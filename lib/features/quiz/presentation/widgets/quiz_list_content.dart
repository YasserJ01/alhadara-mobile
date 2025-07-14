import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_list/quiz_list_bloc.dart';
import '../bloc/quiz_list/quiz_list_state.dart';
import 'empty_quiz_list_widget.dart';
import 'quiz_error_widget.dart';
import 'quiz_list_view.dart';

class QuizListContent extends StatelessWidget {
  final int scheduleSlotId;

  const QuizListContent({super.key, required this.scheduleSlotId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizListBloc, QuizListState>(
      builder: (context, state) {
        if (state is QuizListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is QuizListError) {
          return QuizErrorWidget(
            message: state.message,
            scheduleSlotId: scheduleSlotId,
          );
        }

        if (state is QuizListLoaded) {
          if (state.quizzes.isEmpty) {
            return const EmptyQuizListWidget();
          }

          return QuizListView(quizzes: state.quizzes);
        }

        return const Center(child: Text('Welcome to Quiz'));
      },
    );
  }
}