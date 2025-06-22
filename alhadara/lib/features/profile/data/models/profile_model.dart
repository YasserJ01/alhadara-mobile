import '../../domain/entity/profile.dart';
import 'interest_model.dart';
//data/models/profile_model.dart
class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.birthDate,
    required super.gender,
    required super.address,
    required super.academicStatus,
    required super.image,
    required super.university,
    required super.studyfield,
    required super.interests,
    required super.fullName,
    required super.universityName,
    required super.studyfieldName,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      address: json['address'],
      academicStatus: json['academic_status'],
      // image: json['image']['image'],
      image: json['image'] != null ? json['image']['image'] : null,
      university: json['university'],
      studyfield: json['studyfield'],
      interests: (json['interests'] as List)
          .map((interest) => InterestModel.fromJson(interest))
          .toList(),
      fullName: json['full_name'],
      universityName: json['university_name'],
      studyfieldName: json['studyfield_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'birth_date': birthDate,
      'gender': gender,
      'address': address,
      'academic_status': academicStatus,
      'university': university,
      'studyfield': studyfield,
      'interests': interests.map((interest) =>
          (interest as InterestModel).toJson()).toList(),
      'full_name': fullName,
      'university_name': universityName,
      'studyfield_name': studyfieldName,
    };
  }
}
