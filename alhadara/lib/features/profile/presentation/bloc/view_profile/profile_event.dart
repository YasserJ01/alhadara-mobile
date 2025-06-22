//lib/features/profile/presentation/bloc/profile_event.dart
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
const ProfileEvent();

@override
List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
// final String token;

const LoadProfile();

@override
List<Object> get props => [];
}