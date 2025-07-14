// bloc/homework_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/homework.dart';

abstract class HomeworkState extends Equatable {
  const HomeworkState();

  @override
  List<Object> get props => [];
}

class HomeworkInitial extends HomeworkState {}

class HomeworkLoading extends HomeworkState {}

class HomeworkLoaded extends HomeworkState {
  final List<Homework> homework;

  const HomeworkLoaded(this.homework);

  @override
  List<Object> get props => [homework];
}

class HomeworkEmpty extends HomeworkState {}

class HomeworkError extends HomeworkState {
  final String message;

  const HomeworkError(this.message);

  @override
  List<Object> get props => [message];
}
