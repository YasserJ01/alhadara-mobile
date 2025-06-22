import 'package:equatable/equatable.dart';
import 'interest.dart';

//domain/entity/profile.dart
class Profile extends Equatable {
  final int id;
  final String birthDate;
  final String gender;
  final String address;
  final String academicStatus;
  final String? image;
  final int? university;
  final int? studyfield;
  final List<Interest> interests;
  final String fullName;
  final String? universityName;
  final String? studyfieldName;

  const Profile({
    required this.id,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.academicStatus,
    required this.image,
    required this.university,
    required this.studyfield,
    required this.interests,
    required this.fullName,
    required this.universityName,
    required this.studyfieldName,
  });

  @override
  List<Object?> get props => [
        id,
        birthDate,
        gender,
        address,
        academicStatus,
        image,
        university,
        studyfield,
        interests,
        fullName,
        universityName,
        studyfieldName
      ];
}
