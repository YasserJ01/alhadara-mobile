// part of 'private_lesson_requests_list_bloc.dart';

// enum PrivateLessonRequestsListStatus { initial, loading, success, failure }

// class PrivateLessonRequestsListState extends Equatable {
//   final PrivateLessonRequestsListStatus status;
//   final List<PrivateLessonRequest> requests;
//   final String? errorMessage;

//   const PrivateLessonRequestsListState({
//     this.status = PrivateLessonRequestsListStatus.initial,
//     this.requests = const [],
//     this.errorMessage,
//   });

//   PrivateLessonRequestsListState copyWith({
//     PrivateLessonRequestsListStatus? status,
//     List<PrivateLessonRequest>? requests,
//     String? errorMessage,
//   }) {
//     return PrivateLessonRequestsListState(
//       status: status ?? this.status,
//       requests: requests ?? this.requests,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [status, requests, errorMessage];
// }
part of 'private_lesson_requests_list_bloc.dart';

enum PrivateLessonRequestsListStatus { initial, loading, success, failure }

class PrivateLessonRequestsListState extends Equatable {
  final PrivateLessonRequestsListStatus status;
  final List<PrivateLessonRequest> requests;
  final String? errorMessage;
  final String? showSuccess; 

  const PrivateLessonRequestsListState({
    this.status = PrivateLessonRequestsListStatus.initial,
    this.requests = const [],
    this.errorMessage,
    this.showSuccess 
  });

  PrivateLessonRequestsListState copyWith({
    PrivateLessonRequestsListStatus? status,
    List<PrivateLessonRequest>? requests,
    String? errorMessage,
    String? showSuccess,
  }) {
    return PrivateLessonRequestsListState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: errorMessage ?? this.errorMessage,
      showSuccess: showSuccess ?? this.showSuccess,
    );
  }

  @override
  List<Object?> get props => [status, requests, errorMessage, showSuccess];
}