import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../core/token.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../models/create_profile_request_model.dart';
import '../models/create_profile_response_model.dart';
import '../models/profile_image_model.dart';
import '../models/profile_model.dart';
import '../models/university_model.dart';
import '../models/studyfield_model.dart';

//features/profile/data/datasources/profile_remote_data_source.dart
abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<int> createProfile(CreateProfileRequestModel request);
  Future<List<UniversityModel>> getUniversities();
  Future<List<StudyfieldModel>> getStudyfields();
  Future<ProfileImageModel> uploadProfileImage(File imageFile);
  Future<List<ProfileImageModel>> getProfileImages(); // Add this method
  Future<List<Map<String, dynamic>>> getInterests();
  Future<void> saveUserInterests(int profileId, int interestId, int intensity);

}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/profile/me/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ProfileModel.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw NotFoundException('Profile not found');
    } else {
      throw ServerFailure();
    }
  }

  // @override
  // Future<ProfileModel> getProfile() async {
  //   final response = await client.get(
  //     Uri.parse('http://10.0.2.2:8000/api/core/profile/me/'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'JWT ${Token.token}',
  //     },
  //   );
  //   print('Response status: ${response.statusCode}'); // Debug
  //   print('Response body: ${response.body}'); // Debug
  //
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     return ProfileModel.fromJson(jsonData); // Return the ProfileModel
  //   } else {
  //     throw ServerFailure();
  //   }
  // }

  @override
  Future<int> createProfile(CreateProfileRequestModel request) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/profiles/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
      body: json.encode(request.toJson()),
    );

    print('Create Profile Response status: ${response.statusCode}');
    print('Create Profile Response body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final responseModel = CreateProfileResponseModel.fromJson(jsonData);
      return responseModel.id;
    } else {
      print(Token.token);
      throw ServerFailure();
    }
  }

  @override
  Future<List<UniversityModel>> getUniversities() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/universities/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
    );

    print('Universities Response status: ${response.statusCode}');
    print('Universities Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => UniversityModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<StudyfieldModel>> getStudyfields() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/studyfields/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
    );

    print('Studyfields Response status: ${response.statusCode}');
    print('Studyfields Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => StudyfieldModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<ProfileImageModel> uploadProfileImage(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/core/profile-images/'),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'JWT ${Token.token}', // Make sure Token is imported
      });

      // Add the image file
      String fileName = imageFile.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // This should match your Django field name
          imageFile.path,
          filename: fileName,
        ),
      );

      print('Uploading file: $fileName');
      print('File size: ${await imageFile.length()} bytes');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Upload response status: ${response.statusCode}');
      print('Upload response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return ProfileImageModel.fromJson(jsonData);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      if (e is ServerFailure) rethrow;
      print('Upload error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<ProfileImageModel>> getProfileImages() async {
    try {
      final response = await client.get(
        Uri.parse('http://10.0.2.2:8000/api/core/profile-images/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT ${Token.token}', // Make sure Token is imported
        },
      );

      print('Get images response status: ${response.statusCode}');
      print('Get images response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ProfileImageModel.fromJson(json)).toList();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      if (e is ServerFailure) rethrow;
      print('Get images error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getInterests() async {
    final response = await client.get(Uri.parse('http://10.0.2.2:8000/api/core/interests/'),
        headers: {'Authorization': 'JWT ${Token.token}'}
    );


    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load interests');
    }
  }

  @override
  Future<void> saveUserInterests(int profileId, int interestId, int intensity) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/profiles/$profileId/add_interest/'),
      body: json.encode({
        'interest': interestId,
        'intensity': intensity,
      }),
      headers: {'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save user interests');
    }
  }


}
