import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/colors.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../data/models/exam_attempt_model.dart';
import '../../data/models/question_model.dart';
import '../bloc/entrance_exam_bloc.dart';
import '../bloc/entrance_exam_event.dart';
import '../bloc/entrance_exam_state.dart';
import 'exam_completion_page.dart';

class ExamQuestionsPage extends StatelessWidget {
  final int attemptId;

  const ExamQuestionsPage({Key? key, required this.attemptId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Entrance Exam',
      body: BlocListener<EntranceExamBloc, EntranceExamState>(
        listener: (context, state) {
          if (state is ExamCompleted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ExamCompletionPage(),
              ),
            );
          } else if (state is EntranceExamError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<EntranceExamBloc, EntranceExamState>(
          builder: (context, state) {
            if (state is EntranceExamLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExamLoaded) {
              return _buildExamContent(context, state);
            }

            return const Center(
              child: Text('Something went wrong. Please try again.'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExamContent(BuildContext context, ExamLoaded state) {
    return Column(
      children: [
        _buildExamHeader(state.examAttempt),
        Expanded(
          child: PageView.builder(
            itemCount: state.examAttempt.questions.length,
            itemBuilder: (context, index) {
              final question = state.examAttempt.questions[index];
              return _buildQuestionPage(context, question, state.userAnswers, index, state.examAttempt.questions.length);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExamHeader(ExamAttempt examAttempt) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            examAttempt.examTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Student: ${examAttempt.studentName}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Language: ${examAttempt.languageName}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(
      BuildContext context,
      Question question,
      Map<int, int> userAnswers,
      int questionIndex,
      int totalQuestions,
      ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Question ${questionIndex + 1} of $totalQuestions',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // const Spacer(),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Colors.orange.shade100,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(
              //     '${question.points} pts',
              //     style: TextStyle(
              //       color: Colors.orange.shade800,
              //       fontSize: 12,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            question.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: question.choices.length,
              itemBuilder: (context, choiceIndex) {
                final choice = question.choices[choiceIndex];
                final isSelected = userAnswers[question.id] == choice.order;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.read<EntranceExamBloc>().add(
                          AnswerQuestionEvent(question.id, choice.order),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? Colors.blue.shade50 : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.blue : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                choice.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.blue.shade800 : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          if (questionIndex == totalQuestions - 1)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: userAnswers.length == totalQuestions
                    ? () {
                  _showSubmitDialog(context, attemptId);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit Exam (${userAnswers.length}/$totalQuestions answered)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSubmitDialog(BuildContext context, int attemptId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Submit Exam'),
          content: const Text('Are you sure you want to submit your exam? You cannot change your answers after submission.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<EntranceExamBloc>().add(SubmitAnswersEvent(attemptId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}