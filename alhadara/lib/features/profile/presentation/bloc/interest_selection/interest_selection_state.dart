part of 'interest_selection_bloc.dart';

class InterestSelectionState extends Equatable {
  final List<InterestEntity> allInterests;
  final List<InterestEntity> selectedInterests;
  final bool isLoading;
  final String? error;

  const InterestSelectionState({
    required this.allInterests,
    required this.selectedInterests,
    this.isLoading = false,
    this.error,
  });

  factory InterestSelectionState.initial() {
    return const InterestSelectionState(
      allInterests: [],
      selectedInterests: [],
    );
  }

  InterestSelectionState copyWith({
    List<InterestEntity>? allInterests,
    List<InterestEntity>? selectedInterests,
    bool? isLoading,
    String? error,
  }) {
    return InterestSelectionState(
      allInterests: allInterests ?? this.allInterests,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [allInterests, selectedInterests, isLoading, error];
}