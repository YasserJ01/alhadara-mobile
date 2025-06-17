part of 'profile_image_bloc.dart';

// abstract class ProfileImageState extends Equatable {
//   const ProfileImageState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ProfileImageInitial extends ProfileImageState {}
//
// class ProfileImageLoading extends ProfileImageState {}
//
// class ProfileImageUploaded extends ProfileImageState {
//   final ProfileImage profileImage;
//
//   const ProfileImageUploaded(this.profileImage);
//
//   @override
//   List<Object> get props => [profileImage];
// }
//
// class ProfileImageError extends ProfileImageState {
//   final String message;
//
//   const ProfileImageError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }

abstract class ProfileImageState extends Equatable {
  const ProfileImageState();

  @override
  List<Object> get props => [];
}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoading extends ProfileImageState {}

class ProfileImageUploaded extends ProfileImageState {
  final ProfileImage profileImage;

  const ProfileImageUploaded(this.profileImage);

  @override
  List<Object> get props => [profileImage];
}

class ProfileImagesLoaded extends ProfileImageState {
  final List<ProfileImage> profileImages;

  const ProfileImagesLoaded(this.profileImages);

  @override
  List<Object> get props => [profileImages];
}

class ProfileImageError extends ProfileImageState {
  final String message;

  const ProfileImageError(this.message);

  @override
  List<Object> get props => [message];
}