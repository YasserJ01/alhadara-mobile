import 'package:flutter/material.dart';

import '../../domain/entities/quiz_answer_entity.dart';

class QuizResultsPage extends StatelessWidget {
  final List<QuizAnswer> answers;
  final int totalPoints;

  const QuizResultsPage({
    super.key,
    required this.answers,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Column(
        children: [
          _buildScoreCard(context),
          Expanded(
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context, index) {
                return _buildAnswerCard(answers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context) {
    final correctCount = answers.where((a) => a.isCorrect).length;
    final totalQuestions = answers.length;
    final percentage = (correctCount / totalQuestions * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Your Score: $percentage%',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '$correctCount out of $totalQuestions correct',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Total Points: $totalPoints',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard(QuizAnswer answer) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: answer.isCorrect ? Colors.green[50] : Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              answer.questionText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your answer: ${answer.selectedChoices.first.text}',
              style: TextStyle(
                color: answer.isCorrect ? Colors.green : Colors.red,
              ),
            ),
            if (answer.revisionNote != null) ...[
              const SizedBox(height: 8),
              _buildRevisionNote(answer.revisionNote!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRevisionNote(RevisionNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(note.message),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4.0,
          children: note.lessons.map((lesson) {
            return InkWell(
              onTap: () => _navigateToLesson(lesson.id),
              child: Chip(
                label: Text(lesson.title),
                backgroundColor: Colors.blue[100],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _navigateToLesson(int lessonId) {
    // Implement navigation to lesson page
    print('Navigate to lesson $lessonId');
  }
}