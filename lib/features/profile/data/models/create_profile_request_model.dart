// features/profile/data/models/create_profile_request_model.dart
class CreateProfileRequestModel {
  final String birthDate;
  final String gender;
  final String address;
  final String academicStatus;
  final int? university;
  final int? studyfield;

  const CreateProfileRequestModel({
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.academicStatus,
    this.university,
    this.studyfield,
  });

  Map<String, dynamic> toJson() {
    return {
      'birth_date': birthDate,
      'gender': gender,
      'address': address,
      'academic_status': academicStatus,
      'university': university,
      'studyfield': studyfield,
    };
  }
}
