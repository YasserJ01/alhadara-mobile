import 'dart:io';

import '../entity/profile_image.dart';
import '../repositories/profile_repository.dart';

class UploadProfileImage {
  final ProfileRepository repository;

  UploadProfileImage(this.repository);

  Future<ProfileImage> call(File imageFile) async {
    return await repository.uploadProfileImage(imageFile);
  }
}