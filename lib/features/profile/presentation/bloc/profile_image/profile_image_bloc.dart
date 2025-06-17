import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../errors/failures.dart';
import '../../../domain/entity/profile_image.dart';
import '../../../domain/usecases/get_profile_images.dart';
import '../../../domain/usecases/upload_profile_image.dart';

part 'profile_image_event.dart';
part 'profile_image_state.dart';

//
// class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
//   final UploadProfileImage uploadProfileImage;
//
//   ProfileImageBloc({required this.uploadProfileImage}) : super(ProfileImageInitial()) {
//     on<UploadProfileImageEvent>(_onUploadProfileImage);
//   }
//
//   Future<void> _onUploadProfileImage(
//       UploadProfileImageEvent event,
//       Emitter<ProfileImageState> emit,
//       ) async {
//     emit(ProfileImageLoading());
//
//     try {
//       final profileImage = await uploadProfileImage(event.imageFile);
//       emit(ProfileImageUploaded(profileImage));
//     } catch (failure) {
//       emit(ProfileImageError(_mapFailureToMessage(failure)));
//     }
//   }
//
//   String _mapFailureToMessage(dynamic failure) {
//     if (failure is ServerFailure) {
//       return 'Server error occurred. Please try again.';
//     } else if (failure is HttpFailure) {
//       return 'Network error. Please check your connection.';
//     } else if (failure is DataFormatFailure) {
//       return 'Invalid image format.';
//     } else {
//       return 'An unexpected error occurred.';
//     }
//   }
// }

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final UploadProfileImage uploadProfileImage;
  final GetProfileImages getProfileImages;

  ProfileImageBloc({
    required this.uploadProfileImage,
    required this.getProfileImages,
  }) : super(ProfileImageInitial()) {
    on<UploadProfileImageEvent>(_onUploadProfileImage);
    on<GetProfileImagesEvent>(_onGetProfileImages);
  }

  Future<void> _onUploadProfileImage(
      UploadProfileImageEvent event,
      Emitter<ProfileImageState> emit,
      ) async {
    emit(ProfileImageLoading());

    try {
      final profileImage = await uploadProfileImage(event.imageFile);
      emit(ProfileImageUploaded(profileImage));
    } catch (failure) {
      emit(ProfileImageError(_mapFailureToMessage(failure)));
    }
  }

  Future<void> _onGetProfileImages(
      GetProfileImagesEvent event,
      Emitter<ProfileImageState> emit,
      ) async {
    emit(ProfileImageLoading());

    try {
      final profileImages = await getProfileImages();
      emit(ProfileImagesLoaded(profileImages));
    } catch (failure) {
      emit(ProfileImageError(_mapFailureToMessage(failure)));
    }
  }

  String _mapFailureToMessage(dynamic failure) {
    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again.';
    } else if (failure is HttpFailure) {
      return 'Network error. Please check your connection.';
    } else if (failure is DataFormatFailure) {
      return 'Invalid image format.';
    } else if (failure is NoDataFailure) {
      return 'No profile images found.';
    } else {
      return 'An unexpected error occurred.';
    }
  }
}