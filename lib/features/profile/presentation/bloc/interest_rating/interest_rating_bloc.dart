
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/interests.dart';
import '../../../domain/usecases/save_user_interests_usecase.dart';

part 'interest_rating_event.dart';
part 'interest_rating_state.dart';

class InterestRatingBloc extends Bloc<InterestRatingEvent, InterestRatingState> {
  final SaveUserInterestsUseCase saveUserInterestsUseCase;

  InterestRatingBloc({
    required this.saveUserInterestsUseCase,
    required List<InterestEntity> interests,
  }) : super(InterestRatingState.initial(interests)) {
    on<RateInterestEvent>(_onRateInterest);
    on<SubmitInterestsEvent>(_onSubmitInterests);
  }

  void _onRateInterest(
    RateInterestEvent event,
    Emitter<InterestRatingState> emit,
  ) {
    final newRatings = Map<int, int>.from(state.interestRatings);
    newRatings[event.interest.id] = event.rating;
    emit(state.copyWith(interestRatings: newRatings));
  }

  Future<void> _onSubmitInterests(
    SubmitInterestsEvent event,
    Emitter<InterestRatingState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    
    try {
      for (final entry in state.interestRatings.entries) {
        await saveUserInterestsUseCase(
          event.profileId,
          entry.key,
          entry.value,
        );
      }
      
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      ));
    }
  }
}