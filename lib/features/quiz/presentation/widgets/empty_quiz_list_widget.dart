import 'package:flutter/material.dart';

class EmptyQuizListWidget extends StatelessWidget {
  const EmptyQuizListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No quizzes available',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}