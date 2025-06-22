import 'package:equatable/equatable.dart';
import '../../../domain/entity/studyfield.dart';
import '../../../domain/entity/university.dart';
abstract class UniversityStudyfieldState extends Equatable {
  const UniversityStudyfieldState();

  @override
  List<Object?> get props => [];
}

class UniversityStudyfieldInitial extends UniversityStudyfieldState {}

class UniversityStudyfieldLoading extends UniversityStudyfieldState {}

class UniversitiesAndStudyfieldsLoaded extends UniversityStudyfieldState {
  final List<University> universities;
  final List<Studyfield> studyfields;

  const UniversitiesAndStudyfieldsLoaded({
    required this.universities,
    required this.studyfields,
  });

  @override
  List<Object> get props => [universities, studyfields];
}

class UniversitiesAndStudyfieldsError extends UniversityStudyfieldState {
  final String message;

  const UniversitiesAndStudyfieldsError({required this.message});

  @override
  List<Object> get props => [message];
}
