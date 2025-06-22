part of 'interest_selection_bloc.dart';

abstract class InterestSelectionEvent extends Equatable {
  const InterestSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadInterests extends InterestSelectionEvent {}

class ToggleInterestSelection extends InterestSelectionEvent {
  final InterestEntity interest;

  const ToggleInterestSelection(this.interest);

  @override
  List<Object> get props => [interest];
}

class SubmitSelectedInterests extends InterestSelectionEvent {
  final int profileId;

  const SubmitSelectedInterests(this.profileId);
}