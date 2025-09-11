part of 'private_lesson_request_bloc.dart';

enum PrivateLessonRequestStatus { initial, loading, success, failure }

class PrivateLessonRequestState extends Equatable {
  final PrivateLessonRequestStatus status;
  final PrivateLessonRequest? request;
  final String? errorMessage;

  const PrivateLessonRequestState({
    this.status = PrivateLessonRequestStatus.initial,
    this.request,
    this.errorMessage,
  });

  PrivateLessonRequestState copyWith({
    PrivateLessonRequestStatus? status,
    PrivateLessonRequest? request,
    String? errorMessage,
  }) {
    return PrivateLessonRequestState(
      status: status ?? this.status,
      request: request ?? this.request,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, request, errorMessage];
}