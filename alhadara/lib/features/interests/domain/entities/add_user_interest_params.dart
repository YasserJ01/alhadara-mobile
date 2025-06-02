// features/interests/domain/entities/add_user_interest_params.dart
class AddUserInterestParams {
  final int profileId;
  final int interestId;
  final int intensity;

  AddUserInterestParams({
    required this.profileId,
    required this.interestId,
    required this.intensity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddUserInterestParams &&
          runtimeType == other.runtimeType &&
          profileId == other.profileId &&
          interestId == other.interestId &&
          intensity == other.intensity;

  @override
  int get hashCode =>
      profileId.hashCode ^ interestId.hashCode ^ intensity.hashCode;
}