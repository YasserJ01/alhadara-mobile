import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/delete_private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/get_private_lesson_requests.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/pick_proposed_option.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'private_lesson_requests_list_event.dart';
part 'private_lesson_requests_list_state.dart';

class PrivateLessonRequestsListBloc
    extends Bloc<PrivateLessonRequestsListEvent, PrivateLessonRequestsListState> {
  final GetPrivateLessonRequests getPrivateLessonRequests;
    final PickProposedOption pickProposedOption;
     final DeletePrivateLessonRequest deletePrivateLessonRequest;


  PrivateLessonRequestsListBloc({required this.getPrivateLessonRequests,required this.pickProposedOption,required this.deletePrivateLessonRequest,})
      : super(const PrivateLessonRequestsListState()) {
    on<LoadPrivateLessonRequests>(_onLoadPrivateLessonRequests);
        on<PickProposedOptionEvent>(_onPickProposedOption);
on<DeletePrivateLessonRequestEvent>(_onDeletePrivateLessonRequest);

  }

  Future<void> _onLoadPrivateLessonRequests(
    LoadPrivateLessonRequests event,
    Emitter<PrivateLessonRequestsListState> emit,
  ) async {
    emit(state.copyWith(status: PrivateLessonRequestsListStatus.loading));

    try {
      final requests = await getPrivateLessonRequests.call();
      emit(state.copyWith(
        status: PrivateLessonRequestsListStatus.success,
        requests: requests,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PrivateLessonRequestsListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
   Future<void> _onPickProposedOption(
    PickProposedOptionEvent event,
    Emitter<PrivateLessonRequestsListState> emit,
  ) async {
    emit(state.copyWith(status: PrivateLessonRequestsListStatus.loading));

    try {
      await pickProposedOption.call(
        requestId: event.requestId,
        optionId: event.optionId,
      );
         emit(state.copyWith(
      status: PrivateLessonRequestsListStatus.success,
      showSuccess: 'pick an option done successfully',
    ));
      
      add(LoadPrivateLessonRequests());
    } catch (e) {
      emit(state.copyWith(
        status: PrivateLessonRequestsListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
   Future<void> _onDeletePrivateLessonRequest(
    DeletePrivateLessonRequestEvent event,
    Emitter<PrivateLessonRequestsListState> emit,
  ) async {
    emit(state.copyWith(status: PrivateLessonRequestsListStatus.loading));

    try {
      await deletePrivateLessonRequest.call(event.requestId);
      emit(state.copyWith(
        status: PrivateLessonRequestsListStatus.success,
      showSuccess: 'Request deleted successfully',
      ));
     final requests = await getPrivateLessonRequests.call();
    emit(state.copyWith(
      requests: requests,
      status: PrivateLessonRequestsListStatus.success,
   
    ));
    } catch (e) {
      emit(state.copyWith(
        status: PrivateLessonRequestsListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}