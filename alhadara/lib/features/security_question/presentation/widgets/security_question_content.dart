import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
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
  State<SecurityQuestionContent> createState() =>
      _SecurityQuestionContentState();
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

  Widget _buildQuestionList(
      BuildContext context, List<SecurityQuestionEntity> questions) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.responsiveSize(context,
          mobile: 12, tablet: 20, desktop: 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 16, tablet: 24, desktop: 32)),
          Text(
            'Select Security Question',
            style: TextStyle(
              fontSize: AppSizes.responsiveFontSize(context,
                  mobile: 24, tablet: 28, desktop: 32),
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 8, tablet: 12, desktop: 16)),
          Text(
            "You may need it later",
            style: TextStyle(
              fontSize: AppSizes.responsiveFontSize(context,
                  mobile: 12, tablet: 14, desktop: 16),
              color:AppColors.greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 24, tablet: 32, desktop: 40)),
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
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 16, tablet: 24, desktop: 32)),
          TextField(
            controller:
                _answerController, // Using the state-maintained controller
            decoration: const InputDecoration(
              labelText: 'Your Answer',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 32, tablet: 40, desktop: 48)),
          AppElevatedButton(
              child: Text(
                'Save Security Question',
                style: TextStyle(
                  fontSize: AppSizes.responsiveFontSize(context,
                      mobile: 16, tablet: 18, desktop: 20),
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
              onPressed: () {
                if (_selectedQuestion != null &&
                    _answerController.text.isNotEmpty) {
                  context.read<SecurityQuestionBloc>().add(
                        SubmitSecurityAnswer(
                          token: widget.authToken,
                          questionId: _selectedQuestion!.id,
                          answer: _answerController.text,
                        ),
                      );
                }
              })
          // SizedBox(
          //   height: AppSizes.responsiveSize(context,
          //       mobile: 56, tablet: 64, desktop: 72),
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(1),
          //       ),
          //     ),
          //     onPressed: () {
          //       if (_selectedQuestion != null &&
          //           _answerController.text.isNotEmpty) {
          //         context.read<SecurityQuestionBloc>().add(
          //               SubmitSecurityAnswer(
          //                 token: widget.authToken,
          //                 questionId: _selectedQuestion!.id,
          //                 answer: _answerController.text,
          //               ),
          //             );
          //       }
          //     },
          //     child:
          // Text(
          //       'Save Security Question',
          //       style: TextStyle(
          //         fontSize: AppSizes.responsiveFontSize(context,
          //             mobile: 16, tablet: 18, desktop: 20),
          //         fontWeight: FontWeight.w400,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          ,
          SizedBox(
              height: AppSizes.responsiveSize(context,
                  mobile: 16, tablet: 24, desktop: 32)),
        ],
      ),
    );
  }
}
