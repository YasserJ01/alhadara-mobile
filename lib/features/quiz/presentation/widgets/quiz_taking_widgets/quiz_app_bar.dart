import 'package:flutter/material.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isQuizActive;
  final int remainingSeconds;

  const QuizAppBar({
    super.key,
    required this.isQuizActive,
    required this.remainingSeconds,
  });

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Quiz in Progress'),
      backgroundColor: Colors.red.shade600,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        if (isQuizActive)
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _formatTime(remainingSeconds),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}