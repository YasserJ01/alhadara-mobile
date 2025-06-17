import 'dart:io';

import '../entity/create_profile_request.dart';
import '../entity/interests.dart';
import '../entity/profile.dart';
import '../entity/profile_image.dart';
import '../entity/studyfield.dart';
import '../entity/university.dart';
//domain/repositories/profile_repository.dart
abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<int> createProfile(CreateProfileRequest request);
  Future<List<University>> getUniversities();
  Future<List<Studyfield>> getStudyfields();
  Future<ProfileImage> uploadProfileImage(File imageFile);
  Future<List<ProfileImage>> getProfileImages(); // Add this method
  Future<List<InterestEntity>> getInterests();
  Future<void> saveUserInterests(int profileId, int interestId, int intensity);
}