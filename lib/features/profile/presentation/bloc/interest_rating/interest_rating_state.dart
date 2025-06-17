part of 'interest_rating_bloc.dart';

class InterestRatingState extends Equatable {
  
  final Map<int, int> interestRatings; // interestId -> rating
  final bool isSubmitting;
  final String? error;
  final bool isSuccess;

  const InterestRatingState({
    required this.interestRatings,
    this.isSubmitting = false,
    this.error,
    this.isSuccess = false,
  });

  factory InterestRatingState.initial(List<InterestEntity> interests) {
    return InterestRatingState(
      interestRatings: {
        for (var interest in interests) interest.id: 3, // Default rating of 3
      },
    );
  }

  InterestRatingState copyWith({
    Map<int, int>? interestRatings,
    bool? isSubmitting,
    String? error,
    bool? isSuccess,
  }) {
    return InterestRatingState(
      interestRatings: interestRatings ?? this.interestRatings,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [interestRatings, isSubmitting, error, isSuccess];
}