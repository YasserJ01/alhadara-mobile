part of 'create_profile_bloc.dart';
abstract class CreateProfileState extends Equatable {
  const CreateProfileState();

  @override
  List<Object?> get props => [];
}

class CreateProfileInitial extends CreateProfileState {}

class CreateProfileLoading extends CreateProfileState {}

class CreateProfileSuccess extends CreateProfileState {
  final int profileId;

  const CreateProfileSuccess({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

class CreateProfileError extends CreateProfileState {
  final String message;

  const CreateProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
