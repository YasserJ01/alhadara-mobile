import 'package:alhadara/features/interests/domain/entities/interest.dart';
import 'package:alhadara/features/interests/domain/usecases/get_interests.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'interest_selection_event.dart';
part 'interest_selection_state.dart';

class InterestSelectionBloc extends Bloc<InterestSelectionEvent, InterestSelectionState> {
  final GetInterestsUseCase getInterestsUseCase;

  InterestSelectionBloc({required this.getInterestsUseCase}) : super(InterestSelectionState.initial()) {
    on<LoadInterests>(_onLoadInterests);
    on<ToggleInterestSelection>(_onToggleInterestSelection);
    on<SubmitSelectedInterests>(_onSubmitSelectedInterests);
  }

  Future<void> _onLoadInterests(
    LoadInterests event,
    Emitter<InterestSelectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final interests = await getInterestsUseCase();
      emit(state.copyWith(
        allInterests: interests,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void _onToggleInterestSelection(
    ToggleInterestSelection event,
    Emitter<InterestSelectionState> emit,
  ) {
    final isSelected = state.selectedInterests.contains(event.interest);
    final newSelectedInterests = List<InterestEntity>.from(state.selectedInterests);

    if (isSelected) {
      newSelectedInterests.remove(event.interest);
    } else if (newSelectedInterests.length < 3) {
      newSelectedInterests.add(event.interest);
    }

    emit(state.copyWith(selectedInterests: newSelectedInterests));
  }

  void _onSubmitSelectedInterests(
    SubmitSelectedInterests event,
    Emitter<InterestSelectionState> emit,
  ) {
    if (state.selectedInterests.isNotEmpty) {
      // Navigation to rating page will be handled by the UI
      emit(state.copyWith());
    }
  }
}