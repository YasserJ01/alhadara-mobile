// Events
import 'package:equatable/equatable.dart';

abstract class QuizListEvent extends Equatable {
  const QuizListEvent();

  @override
  List<Object> get props => [];
}

class LoadQuizzesEvent extends QuizListEvent {
  final int scheduleSlotId;

  const LoadQuizzesEvent({required this.scheduleSlotId});

  @override
  List<Object> get props => [scheduleSlotId];
}