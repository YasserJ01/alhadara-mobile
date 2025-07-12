part of 'private_lesson_requests_list_bloc.dart';

abstract class PrivateLessonRequestsListEvent extends Equatable {
  const PrivateLessonRequestsListEvent();

  @override
  List<Object> get props => [];
}

class LoadPrivateLessonRequests extends PrivateLessonRequestsListEvent {}

class PickProposedOptionEvent extends PrivateLessonRequestsListEvent {
  final int requestId;
  final int optionId;

  const PickProposedOptionEvent({
    required this.requestId,
    required this.optionId,
  });

  @override
  List<Object> get props => [requestId, optionId];
}
class DeletePrivateLessonRequestEvent extends PrivateLessonRequestsListEvent {
  final int requestId;

  const DeletePrivateLessonRequestEvent(this.requestId);

  @override
  List<Object> get props => [requestId];
}
