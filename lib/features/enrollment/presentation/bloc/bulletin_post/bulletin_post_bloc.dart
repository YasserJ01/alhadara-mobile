// Bloc
import 'package:bloc/bloc.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/entities/bulletin_post_entity.dart';
import '../../../domain/usecases/publish_post_usecase.dart';
import 'bulletin_post_event.dart';
import 'bulletin_post_state.dart';

class BulletinPostBloc extends Bloc<BulletinPostEvent, BulletinPostState> {
  final PublishPostUseCase publishPostUseCase;

  BulletinPostBloc({required this.publishPostUseCase})
      : super(BulletinPostInitial()) {
    on<PostTypeChanged>(_onPostTypeChanged);
    on<TitleChanged>(_onTitleChanged);
    on<ContentChanged>(_onContentChanged);
    on<FileSelected>(_onFileSelected);
    on<ImageSelected>(_onImageSelected);
    on<PublishPost>(_onPublishPost);
    on<ResetForm>(_onResetForm);
  }

  void _onPostTypeChanged(PostTypeChanged event, Emitter<BulletinPostState> emit) {
    final currentState = state;
    if (currentState is BulletinPostFormState) {
      emit(currentState.copyWith(
        type: event.type,
        filePath: null,
        imagePath: null,
        errorMessage: null,
      ));
    } else {
      emit(BulletinPostFormState(
        type: event.type,
        title: '',
        content: '',
      ));
    }
  }

  void _onTitleChanged(TitleChanged event, Emitter<BulletinPostState> emit) {
    final currentState = state;
    if (currentState is BulletinPostFormState) {
      emit(currentState.copyWith(title: event.title, errorMessage: null));
    } else {
      emit(BulletinPostFormState(
        type: PostType.message,
        title: event.title,
        content: '',
      ));
    }
  }

  void _onContentChanged(ContentChanged event, Emitter<BulletinPostState> emit) {
    final currentState = state;
    if (currentState is BulletinPostFormState) {
      emit(currentState.copyWith(content: event.content, errorMessage: null));
    } else {
      emit(BulletinPostFormState(
        type: PostType.message,
        title: '',
        content: event.content,
      ));
    }
  }

  void _onFileSelected(FileSelected event, Emitter<BulletinPostState> emit) {
    final currentState = state;
    if (currentState is BulletinPostFormState) {
      emit(currentState.copyWith(filePath: event.filePath, errorMessage: null));
    }
  }

  void _onImageSelected(ImageSelected event, Emitter<BulletinPostState> emit) {
    final currentState = state;
    if (currentState is BulletinPostFormState) {
      emit(currentState.copyWith(imagePath: event.imagePath, errorMessage: null));
    }
  }

  void _onPublishPost(PublishPost event, Emitter<BulletinPostState> emit) async {
    final currentState = state;
    if (currentState is BulletinPostFormState && currentState.isFormValid) {
      emit(currentState.copyWith(isPublishing: true, errorMessage: null));

      try {
        final entity = BulletinPostEntity(
          scheduleSlotId: event.scheduleSlotId,
          type: currentState.type,
          title: currentState.title,
          content: currentState.content,
          filePath: currentState.filePath,
          imagePath: currentState.imagePath,
        );

        await publishPostUseCase(entity);
        emit(BulletinPostSuccess());
      } on ServerFailure {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: 'Server error occurred. Please try again.',
        ));
      } on UnauthorizedFailure {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: 'You are not authorized to perform this action.',
        ));
      } on ValidationFailure {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: 'Please check your input and try again.',
        ));
      } on NotFoundFailure catch (failure) {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: failure.message,
        ));
      } on HttpFailure {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: 'Network error occurred. Please check your connection.',
        ));
      } catch (e) {
        emit(currentState.copyWith(
          isPublishing: false,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ));
      }
    }
  }

  void _onResetForm(ResetForm event, Emitter<BulletinPostState> emit) {
    emit(BulletinPostFormState(
      type: PostType.message,
      title: '',
      content: '',
    ));
  }
}