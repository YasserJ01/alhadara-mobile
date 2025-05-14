import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/security_question_entity.dart';
import '../bloc/security_question_bloc.dart';

// class SecurityQuestionContent extends StatelessWidget {
//   final String authToken; // Add this parameter
//
//   const SecurityQuestionContent({super.key,required this.authToken});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SecurityQuestionBloc, SecurityQuestionState>(
//       listener: (context, state) {
//         if (state is SecurityQuestionSelected) {
//           Navigator.pop(context);
//           // Navigate to next screen
//         }
//       },
//       builder: (context, state) {
//         if (state is SecurityQuestionsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (state is SecurityQuestionsLoaded) {
//           return _buildQuestionList(context, state.questions);
//         }
//
//         if (state is SecurityQuestionError) {
//           return Text(state.message);
//         }
//
//         return const SizedBox();
//       },
//     );
//   }
//   Widget _buildQuestionList(
//       BuildContext context, List<SecurityQuestionEntity> questions) {
//     final answerController = TextEditingController();
//     SecurityQuestionEntity? selectedQuestion;
//
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         const Text(
//           'Select Security Question',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         DropdownButtonFormField<SecurityQuestionEntity>(
//           items: questions.map((question) {
//             return DropdownMenuItem(
//               value: question,
//               child: Text(
//                 question.questionText,
//                 style: const TextStyle(fontSize: 18),
//                 textDirection: question.language == 'ar'
//                     ? TextDirection.rtl
//                     : TextDirection.ltr,
//                 textAlign: question.language == 'ar'
//                     ? TextAlign.right
//                     : TextAlign.left,
//               ),
//             );
//           }).toList(),
//           onChanged: (question) => selectedQuestion = question,
//           decoration: const InputDecoration(
//             labelText: 'Select a question',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: answerController,
//           decoration: const InputDecoration(
//             labelText: 'Your Answer',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             if (selectedQuestion != null && answerController.text.isNotEmpty) {
//               context.read<SecurityQuestionBloc>().add(
//                 SubmitSecurityAnswer(
//                   token: authToken,
//                   questionId: selectedQuestion!.id,
//                   answer: answerController.text,
//                 ),
//               );
//             }
//           },
//           child: const Text('Save Security Question'),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//  }

class SecurityQuestionContent extends StatefulWidget {
  final String authToken;

  const SecurityQuestionContent({super.key, required this.authToken});

  @override
  State<SecurityQuestionContent> createState() => _SecurityQuestionContentState();
}

class _SecurityQuestionContentState extends State<SecurityQuestionContent> {
  final TextEditingController _answerController = TextEditingController();
  SecurityQuestionEntity? _selectedQuestion;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecurityQuestionBloc, SecurityQuestionState>(
      listener: (context, state) {
        if (state is SecurityAnswerSubmitted) {
          Navigator.pop(context);
          // Navigate to next screen
        }
      },
      builder: (context, state) {
        if (state is SecurityQuestionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SecurityQuestionsLoaded) {
          return _buildQuestionList(context, state.questions);
        }

        if (state is SecurityQuestionError) {
          return Text(state.message);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildQuestionList(BuildContext context, List<SecurityQuestionEntity> questions) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Select Security Question',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<SecurityQuestionEntity>(
          items: questions.map((question) {
            return DropdownMenuItem(
              value: question,
              child: Text(
                question.questionText,
                style: const TextStyle(fontSize: 18),
                textDirection: question.language == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            );
          }).toList(),
          onChanged: (question) {
            setState(() {
              _selectedQuestion = question;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Select a question',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _answerController, // Using the state-maintained controller
          decoration: const InputDecoration(
            labelText: 'Your Answer',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_selectedQuestion != null && _answerController.text.isNotEmpty) {
              context.read<SecurityQuestionBloc>().add(
                SubmitSecurityAnswer(
                  token: widget.authToken,
                  questionId: _selectedQuestion!.id,
                  answer: _answerController.text,
                ),
              );
            }
          },
          child: const Text('Save Security Question'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}