// lib/presentation/blocs/localization/localization_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_current_language.dart';
import '../../domain/usecases/save_language.dart';
import '../../../core/usecases/usecase.dart';
import 'localization_event.dart';
import 'localization_state.dart';

@injectable
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final GetCurrentLanguage getCurrentLanguage;
  final SaveLanguage saveLanguage;

  LocalizationBloc({
    required this.getCurrentLanguage,
    required this.saveLanguage,
  }) : super(LocalizationInitial()) {
    on<LoadCurrentLanguage>(_onLoadCurrentLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadCurrentLanguage(
      LoadCurrentLanguage event,
      Emitter<LocalizationState> emit,
      ) async {
    emit(LocalizationLoading());

    final result = await getCurrentLanguage(NoParams());

    result.fold(
          (failure) => emit(LocalizationError(failure.toString())),
          (language) => emit(LocalizationLoaded(language)),
    );
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event,
      Emitter<LocalizationState> emit,
      ) async {
    emit(LocalizationLoading());

    final result = await saveLanguage(
      SaveLanguageParams(language: event.language),
    );

    result.fold(
          (failure) => emit(LocalizationError(failure.toString())),
          (_) => emit(LocalizationLoaded(event.language)),
    );
  }
}
