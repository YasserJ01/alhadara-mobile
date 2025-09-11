// presentation/pages/quiz_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../bloc/quiz_attempt/quiz_attempt_bloc.dart';
import '../bloc/quiz_attempt/quiz_attempt_event.dart';
import '../bloc/quiz_attempt/quiz_attempt_state.dart';
import '../bloc/quiz_list/quiz_list_bloc.dart';
import '../bloc/quiz_list/quiz_list_event.dart';
import '../bloc/quiz_list/quiz_list_state.dart';
import '../../domain/entities/quiz_entity.dart';

import '../bloc/quiz_questions/quiz_questions_bloc.dart';
import '../widgets/quiz_list_content.dart';
import 'quiz_taking_page.dart';

class QuizListPage extends StatelessWidget {
  final int scheduleSlotId;

  const QuizListPage({super.key, required this.scheduleSlotId});

  @override
  Widget build(BuildContext context) {
    // Initialize the bloc when the page is built
    context.read<QuizListBloc>().add(LoadQuizzesEvent(scheduleSlotId: scheduleSlotId));

    return AppScaffold(
      title:'Quizzes',
      // appBar: AppBar(
      //   title: const Text('Available Quizzes'),
      //   backgroundColor: Colors.blue.shade600,
      //   foregroundColor: Colors.white,
      // ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<QuizAttemptBloc, QuizAttemptState>(
            listener: (context, state) {
              if (state is QuizAttemptStarted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (context) => getIt<QuizAttemptBloc>()),
                        BlocProvider(create: (context) => getIt<QuizQuestionsBloc>()),
                      ],
                      child: QuizTakingPage(
                        quizId: state.attempt.quiz,
                        timeLimitMinutes: 0,
                        attemptId: state.attempt.id,
                      ),
                    ),
                  ),
                );
              }
              if (state is QuizAttemptError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error starting quiz: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: QuizListContent(scheduleSlotId: scheduleSlotId),
      ),
    );
  }
}
