// bloc/homework_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/usecases/get_homework_by_lesson_id.dart';
import 'homework_event.dart';
import 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  final GetHomeworkByLessonId getHomeworkByLessonId;

  HomeworkBloc({required this.getHomeworkByLessonId}) : super(HomeworkInitial()) {
    on<GetHomeworkByLessonIdEvent>(_onGetHomeworkByLessonId);
  }

  Future<void> _onGetHomeworkByLessonId(
      GetHomeworkByLessonIdEvent event,
      Emitter<HomeworkState> emit,
      ) async {
    emit(HomeworkLoading());

    try {
      final homework = await getHomeworkByLessonId(event.lessonId);

      if (homework.isEmpty) {
        emit(HomeworkEmpty());
      } else {
        emit(HomeworkLoaded(homework));
      }
    } catch (failure) {
      String message = 'An error occurred';

      if (failure is ServerFailure) {
        message = 'Server error occurred';
      } else if (failure is HttpFailure) {
        message = 'Network error occurred';
      } else if (failure is NotFoundFailure) {
        message = failure.message;
      } else if (failure is CacheFailure) {
        message = 'Cache error occurred';
      }

      emit(HomeworkError(message));
    }
  }
}
