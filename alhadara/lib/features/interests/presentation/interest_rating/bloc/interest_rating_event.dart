// // part of 'interest_rating_bloc.dart';

// // abstract class InterestRatingEvent extends Equatable {
// //   const InterestRatingEvent();

// //   @override
// //   List<Object> get props => [];
// // }

// // class RateInterest extends InterestRatingEvent {
// //   final InterestEntity interest;
// //   final int rating;

// //   const RateInterest(this.interest, this.rating);

// //   @override
// //   List<Object> get props => [interest, rating];
// // }

// // class SubmitRatings extends InterestRatingEvent {
// //   final int profileId;

// //   const SubmitRatings(this.profileId);
// // }
// part of 'interest_rating_bloc.dart';

// abstract class InterestRatingEvent extends Equatable {
//   const InterestRatingEvent();

//   @override
//   List<Object> get props => [];
// }

// class RateInterestEvent extends InterestRatingEvent {  // Changed from RateInterest to RateInterestEvent
//   final InterestEntity interest;
//   final int rating;

//   const RateInterestEvent(this.interest, this.rating);

//   @override
//   List<Object> get props => [interest, rating];
// }

// class SubmitRatingsEvent extends InterestRatingEvent {  // Changed from SubmitRatings to SubmitRatingsEvent
//   final int profileId;

//   const SubmitRatingsEvent(this.profileId);

//   @override
//   List<Object> get props => [profileId];
// }
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