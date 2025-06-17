import 'package:equatable/equatable.dart';
//domain/entity/create_profile_request.dart
class CreateProfileRequest extends Equatable {
  final String birthDate;
  final String gender;
  final String address;
  final String academicStatus;
  final int? university;
  final int? studyfield;

  const CreateProfileRequest({
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.academicStatus,
    this.university,
    this.studyfield,
  });

  @override
  List<Object?> get props => [
    birthDate, gender, address, academicStatus, university, studyfield
  ];
}