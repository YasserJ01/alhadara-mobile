part of 'interest_rating_bloc.dart';

abstract class InterestRatingEvent extends Equatable {
  const InterestRatingEvent();

  @override
  List<Object> get props => [];
}

class RateInterestEvent extends InterestRatingEvent {
  final InterestEntity interest;
  final int rating;

  const RateInterestEvent(this.interest, this.rating);

  @override
  List<Object> get props => [interest, rating];
}

class SubmitInterestsEvent extends InterestRatingEvent {  // Changed from SubmitRatings to SubmitInterestsEvent
  final int profileId;

  const SubmitInterestsEvent(this.profileId);

  @override
  List<Object> get props => [profileId];
}