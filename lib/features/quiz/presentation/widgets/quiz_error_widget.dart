import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_list/quiz_list_bloc.dart';
import '../bloc/quiz_list/quiz_list_event.dart';

class QuizErrorWidget extends StatelessWidget {
  final String message;
  final int? scheduleSlotId; // Make this optional

  const QuizErrorWidget({
    super.key,
    required this.message,
    this.scheduleSlotId, // Now optional
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: TextStyle(color: Colors.red.shade600, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<QuizListBloc>().add(
              LoadQuizzesEvent(scheduleSlotId: scheduleSlotId!),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}