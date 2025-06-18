//lib/features/profile/presentation/bloc/profile_state.dart

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
const ProfileState();

@override
List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
final Profile profile;

const ProfileLoaded(this.profile);

@override
List<Object> get props => [profile];
}

class ProfileNotFound extends ProfileState {}

class ProfileError extends ProfileState {
final String message;

const ProfileError(this.message);

@override
List<Object> get props => [message];
}