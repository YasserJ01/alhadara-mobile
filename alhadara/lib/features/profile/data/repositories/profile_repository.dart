import 'dart:io';
import '../../../../errors/expections.dart';
import '../../domain/entity/create_profile_request.dart';
import '../../domain/entity/interests.dart';
import '../../domain/entity/profile.dart';
import '../../domain/entity/profile_image.dart';
import '../../domain/entity/studyfield.dart';
import '../../domain/entity/university.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../../../errors/failures.dart';
import '../models/create_profile_request_model.dart';
import '../models/interests_model.dart';

//data/repositories/profile_repository.dart
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    try {
      final profileModel = await remoteDataSource.getProfile();
      print('Repository received model: $profileModel');
      return profileModel; // ProfileModel extends Profile
    } on NotFoundException catch (e) {
      print('Profile not found: $e');
      throw NotFoundFailure(e.message);
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  // @override
  // Future<Profile> getProfile() async {
  //   try {
  //     final profileModel = await remoteDataSource.getProfile();
  //     print('Repository received model: $profileModel');
  //     return profileModel; // ProfileModel extends Profile
  //   } on FormatException catch (e) {
  //     print('Repository format error: $e');
  //     throw DataFormatFailure();
  //   } on HttpException catch (e) {
  //     print('Repository HTTP error: $e');
  //     throw ServerFailure();
  //   } catch (e) {
  //     print('Repository unexpected error: $e');
  //     throw ServerFailure();
  //   }
  // }

  @override
  Future<int> createProfile(CreateProfileRequest request) async {
    try {
      final requestModel = CreateProfileRequestModel(
        birthDate: request.birthDate,
        gender: request.gender,
        address: request.address,
        academicStatus: request.academicStatus,
        university: request.university,
        studyfield: request.studyfield,
      );
      final profileId = await remoteDataSource.createProfile(requestModel);
      return profileId;
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<University>> getUniversities() async {
    try {
      final universities = await remoteDataSource.getUniversities();
      return universities;
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<Studyfield>> getStudyfields() async {
    try {
      final studyfields = await remoteDataSource.getStudyfields();
      return studyfields;
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<ProfileImage> uploadProfileImage(File imageFile) async {
    try {
      final profileImageModel =
          await remoteDataSource.uploadProfileImage(imageFile);
      return ProfileImage(
        id: profileImageModel.id,
        image: profileImageModel.image,
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure();
    }
  }

  @override
  Future<List<ProfileImage>> getProfileImages() async {
    try {
      final profileImageModels = await remoteDataSource.getProfileImages();
      return profileImageModels
          .map((model) => ProfileImage(
                id: model.id,
                image: model.image,
              ))
          .toList();
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure();
    }
  }

  @override
  Future<List<InterestEntity>> getInterests() async {
    final interests = await remoteDataSource.getInterests();
    return interests.map((interest) => InterestsModel.fromJson(interest).toEntity()).toList();
  }

  @override
  Future<void> saveUserInterests(int profileId, int interestId, int intensity) {
    return remoteDataSource.saveUserInterests(profileId, interestId, intensity);
  }

}
