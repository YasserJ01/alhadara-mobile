import 'package:equatable/equatable.dart';

abstract class UniversityStudyfieldEvent extends Equatable {
  const UniversityStudyfieldEvent();

  @override
  List<Object?> get props => [];
}

class LoadUniversitiesAndStudyfields extends UniversityStudyfieldEvent {}
