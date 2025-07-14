// presentation/pages/quiz_taking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../bloc/quiz_questions/quiz_questions_bloc.dart';
import '../bloc/quiz_questions/quiz_questions_event.dart';
import '../bloc/quiz_submission/quiz_submission_bloc.dart';
import '../widgets/quiz_taking_widgets/quiz_taking_content.dart';

class QuizTakingPage extends StatelessWidget {
  final int quizId;
  final int timeLimitMinutes;
  final int attemptId; // Add this


  const QuizTakingPage({
    super.key,
    required this.quizId,
    required this.timeLimitMinutes,
    required this.attemptId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<QuizQuestionsBloc>()
            ..add(
              LoadQuizQuestionsEvent(quizId: quizId),
            ),
        ),
        BlocProvider(
          create: (context) => getIt<QuizSubmissionBloc>(),
        ),
      ],
      // child: BlocProvider(
      //   create: (context) => getIt<QuizQuestionsBloc>()
      //     ..add(LoadQuizQuestionsEvent(quizId: quizId)),
      child: QuizTakingContent(attemptId: attemptId),
      // ),
    );
  }
}
// class QuizTakingPage extends StatefulWidget {
//   final int quizId;
//   final int timeLimitMinutes;
//
//   const QuizTakingPage({
//     super.key,
//     required this.quizId,
//     required this.timeLimitMinutes,
//   });
//
//   @override
//   State<QuizTakingPage> createState() => _QuizTakingPageState();
// }
//
// class _QuizTakingPageState extends State<QuizTakingPage> with WidgetsBindingObserver {
//   Timer? _timer;
//   int _remainingSeconds = 0;
//   bool _isQuizActive = false;
//   Map<int, int> _selectedAnswers = {};
//   late QuizQuestionEntity _quizData;
//   bool _hasWarned = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _preventScreenshots();
//     context.read<QuizBloc>().add(LoadQuizQuestionsEvent(quizId: widget.quizId));
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     if (_isQuizActive) {
//       switch (state) {
//         case AppLifecycleState.paused:
//         case AppLifecycleState.inactive:
//         case AppLifecycleState.detached:
//           _showSecurityWarning();
//           break;
//         case AppLifecycleState.resumed:
//           if (_hasWarned) {
//             _endQuizWithFailure();
//           }
//           break;
//         default:
//           break;
//       }
//     }
//   }
//
//   void _preventScreenshots() {
//     // Prevent screenshots on Android
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//   }
//
//   void _startTimer(int minutes) {
//     _remainingSeconds = minutes * 60;
//     _isQuizActive = true;
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         setState(() {
//           _remainingSeconds--;
//         });
//       } else {
//         _endQuizWithTimeout();
//       }
//     });
//   }
//
//   void _endQuizWithTimeout() {
//     _timer?.cancel();
//     _isQuizActive = false;
//     _showTimeoutDialog();
//   }
//
//   void _endQuizWithFailure() {
//     _timer?.cancel();
//     _isQuizActive = false;
//     _showFailureDialog();
//   }
//
//   void _showSecurityWarning() {
//     if (!_hasWarned) {
//       _hasWarned = true;
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => AlertDialog(
//           title: const Text('Security Warning'),
//           content: const Text(
//             'You cannot leave the quiz application. Your quiz will be terminated and marked as failed.',
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _endQuizWithFailure();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red.shade600,
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('End Quiz'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void _showTimeoutDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text('Time\'s Up!'),
//         content: const Text('The quiz time has expired. Your answers have been submitted.'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showFailureDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text('Quiz Terminated'),
//         content: const Text(
//           'The quiz has been terminated due to security violation. You cannot take another attempt for this quiz. Your score will be 0.',
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red.shade600,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatTime(int seconds) {
//     final minutes = seconds ~/ 60;
//     final remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return WillPopScope(
//     //   onWillPop: () async {
//     //     if (_isQuizActive) {
//     //       _showExitWarning();
//     //       return false;
//     //     }
//     //     return true;
//     //   },
//     return PopScope(
//       canPop: !_isQuizActive,
//       onPopInvoked: (bool didPop) {
//         if (!didPop && _isQuizActive) {
//           _showExitWarning();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Quiz in Progress'),
//           backgroundColor: Colors.red.shade600,
//           foregroundColor: Colors.white,
//           automaticallyImplyLeading: false,
//           actions: [
//             if (_isQuizActive)
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 margin: const EdgeInsets.only(right: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   _formatTime(_remainingSeconds),
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         body: BlocConsumer<QuizBloc, QuizState>(
//           listener: (context, state) {
//             if (state is QuizError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Error: ${state.message}')),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is QuizLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (state is QuizQuestionsLoaded) {
//               _quizData = state.questions;
//               if (!_isQuizActive) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   _startTimer(state.questions.timeLimitMinutes);
//                 });
//               }
//               return _buildQuizContent();
//             }
//
//             if (state is QuizError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error, size: 64, color: Colors.red.shade400),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Error loading quiz: ${state.message}',
//                       style: TextStyle(color: Colors.red.shade600, fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Go Back'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuizContent() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.blue.shade50, Colors.white],
//         ),
//       ),
//       child: Column(
//         children: [
//           // Quiz Header
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _quizData.quizTitle,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Time Limit: ${_quizData.timeLimitMinutes} minutes',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 Text(
//                   'Questions: ${_quizData.questions.length}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Questions List
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _quizData.questions.length,
//               itemBuilder: (context, index) {
//                 final question = _quizData.questions[index];
//                 return _buildQuestionCard(question, index);
//               },
//             ),
//           ),
//           // Submit Button
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             child: ElevatedButton(
//               onPressed: _isQuizActive ? _submitQuiz : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green.shade600,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Submit Quiz',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuestionCard(QuizQuestionItemEntity question, int questionIndex) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade600,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${question.order}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         question.text,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Type: ${question.questionType.replaceAll('_', ' ').toUpperCase()} | Points: ${question.points}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ...question.choices.map((choice) {
//               return RadioListTile<int>(
//                 title: Text(choice.text),
//                 value: choice.order,
//                 groupValue: _selectedAnswers[question.order],
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedAnswers[question.order] = value!;
//                   });
//                 },
//                 activeColor: Colors.blue.shade600,
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showExitWarning() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Exit Quiz Warning'),
//         content: const Text(
//           'You cannot do another attempt for this quiz. Your score will be 0 and you will fail. Are you sure you want to exit?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Stay'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _endQuizWithFailure();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red.shade600,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Exit'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _submitQuiz() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Submit Quiz'),
//         content: Text(
//           'Are you sure you want to submit your quiz? You have answered ${_selectedAnswers.length} out of ${_quizData.questions.length} questions.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _finalSubmit();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green.shade600,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _finalSubmit() {
//     _timer?.cancel();
//     _isQuizActive = false;
//
//     // Here you would typically call an API to submit the answers
//     // For now, we'll just show a success dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text('Quiz Submitted'),
//         content: const Text('Your quiz has been submitted successfully!'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
