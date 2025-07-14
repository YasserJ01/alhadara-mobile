// presentation/pages/quiz_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Quizzes'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
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

// class QuizListPage extends StatefulWidget {
//   final int scheduleSlotId;
//
//   const QuizListPage({super.key, required this.scheduleSlotId});
//
//   @override
//   State<QuizListPage> createState() => _QuizListPageState();
// }
//
// class _QuizListPageState extends State<QuizListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<QuizBloc>()
//         .add(LoadQuizzesEvent(scheduleSlotId: widget.scheduleSlotId));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Quizzes'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//       ),
//       body: BlocConsumer<QuizBloc, QuizState>(
//         listener: (context, state) {
//           if (state is QuizAttemptStarted) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BlocProvider(
//                   create: (context) => getIt<QuizBloc>(),
//                   child: QuizTakingPage(
//                     quizId: state.attempt.quiz,
//                     timeLimitMinutes: 0, // Will be set from questions API
//                   ), // Replace with actual schedule slot ID
//                 ),
//                 //     QuizTakingPage(
//                 //   quizId: state.attempt.quiz,
//                 //   timeLimitMinutes: 0, // Will be set from questions API
//                 // ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is QuizLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is QuizError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, size: 64, color: Colors.red.shade400),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error: ${state.message}',
//                     style: TextStyle(color: Colors.red.shade600, fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => context.read<QuizBloc>().add(
//                           LoadQuizzesEvent(
//                               scheduleSlotId: widget.scheduleSlotId),
//                         ),
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           if (state is QuizzesLoaded) {
//             if (state.quizzes.isEmpty) {
//               return const Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
//                     SizedBox(height: 16),
//                     Text(
//                       'No quizzes available',
//                       style: TextStyle(fontSize: 18, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView.builder(
//                 itemCount: state.quizzes.length,
//                 itemBuilder: (context, index) {
//                   final quiz = state.quizzes[index];
//                   return _buildQuizCard(quiz);
//                 },
//               ),
//             );
//           }
//
//           return const Center(child: Text('Welcome to Quiz'));
//         },
//       ),
//     );
//   }
//
//   Widget _buildQuizCard(QuizEntity quiz) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               quiz.title,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               quiz.description,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Icon(
//                   quiz.isAvailable ? Icons.check_circle : Icons.cancel,
//                   color: quiz.isAvailable ? Colors.green : Colors.red,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   quiz.availabilityMessage,
//                   style: TextStyle(
//                     color: quiz.isAvailable ? Colors.green : Colors.red,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             if (quiz.isActive && quiz.isAvailable)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => _showQuizDetailsDialog(quiz),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade600,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                   child: const Text('Take Quiz'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showQuizDetailsDialog(QuizEntity quiz) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text(quiz.title),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Description: ${quiz.description}'),
//             const SizedBox(height: 8),
//             Text('Time Limit: ${quiz.timeLimitMinutes} minutes'),
//             const SizedBox(height: 8),
//             Text('Passing Score: ${quiz.passingScore}'),
//             const SizedBox(height: 8),
//             Text('Questions: ${quiz.questionsCount}'),
//             const SizedBox(height: 8),
//             Text('Max Attempts: ${quiz.maxAttempts}'),
//             const SizedBox(height: 8),
//             Text('Your Attempts: ${quiz.userAttemptsCount}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _showConfirmationDialog(quiz);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue.shade600,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('SUBMIT'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showConfirmationDialog(QuizEntity quiz) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Quiz Start'),
//         content: const Text(
//             'Are you sure you want to start this quiz? Once started, you cannot pause or restart.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('No'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               context
//                   .read<QuizBloc>()
//                   .add(StartQuizAttemptEvent(quizId: quiz.id));
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red.shade600,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );
//   }
// }
