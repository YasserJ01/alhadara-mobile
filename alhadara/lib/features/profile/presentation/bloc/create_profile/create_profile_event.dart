part of 'create_profile_bloc.dart';
abstract class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateProfileSubmitted extends CreateProfileEvent {
  final String birthDate;
  final String gender;
  final String address;
  final String academicStatus;
  final int? university;
  final int? studyfield;

  const CreateProfileSubmitted({
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