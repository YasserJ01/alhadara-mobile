// presentation/bloc/update_profile_event.dart
part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileSubmitted extends UpdateProfileEvent {
  final int profileId;
  final CreateProfileRequest request;

  const UpdateProfileSubmitted({
    required this.profileId,
    required this.request,
  });

  @override
  List<Object?> get props => [profileId, request];
}