part of 'private_lesson_request_bloc.dart';

abstract class PrivateLessonRequestEvent extends Equatable {
  const PrivateLessonRequestEvent();

  @override
  List<Object> get props => [];
}

class SubmitPrivateLessonRequest extends PrivateLessonRequestEvent {
  final int scheduleSlot;
  final String preferredDate;
  final String preferredTimeFrom;
  final String preferredTimeTo;

  const SubmitPrivateLessonRequest({
    required this.scheduleSlot,
    required this.preferredDate,
    required this.preferredTimeFrom,
    required this.preferredTimeTo,
  });

  @override
  List<Object> get props => [
        scheduleSlot,
        preferredDate,
        preferredTimeFrom,
        preferredTimeTo,
      ];
}