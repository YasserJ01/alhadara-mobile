part of 'profile_image_bloc.dart';
// abstract class ProfileImageEvent extends Equatable {
//   const ProfileImageEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class UploadProfileImageEvent extends ProfileImageEvent {
//   final File imageFile;
//
//   const UploadProfileImageEvent(this.imageFile);
//
//   @override
//   List<Object> get props => [imageFile];
// }

abstract class ProfileImageEvent extends Equatable {
  const ProfileImageEvent();

  @override
  List<Object> get props => [];
}

class UploadProfileImageEvent extends ProfileImageEvent {
  final File imageFile;

  const UploadProfileImageEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class GetProfileImagesEvent extends ProfileImageEvent {
  const GetProfileImagesEvent();
}