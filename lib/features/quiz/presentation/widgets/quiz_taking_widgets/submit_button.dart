import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onSubmit;
  final int answeredCount;
  final int totalQuestions;

  const SubmitButton({
    super.key,
    required this.isActive,
    this.onSubmit,
    required this.answeredCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: isActive ? onSubmit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Submit Quiz',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}