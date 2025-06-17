import 'package:bloc/bloc.dart';
import 'package:project2/features/profile/presentation/bloc/university_and_study_field_selection/university_studyfield_event.dart';
import 'package:project2/features/profile/presentation/bloc/university_and_study_field_selection/university_studyfield_state.dart';

import '../../../domain/entity/create_profile_request.dart';
import '../../../domain/usecases/create_profile.dart';
import '../../../domain/usecases/get_studyfields.dart';
import '../../../domain/usecases/get_universities.dart';
//bloc/university_studyfield_bloc.dart
class UniversityStudyfieldBloc extends Bloc<UniversityStudyfieldEvent, UniversityStudyfieldState> {
  final GetUniversities getUniversities;
  final GetStudyfields getStudyfields;

  UniversityStudyfieldBloc({
    required this.getUniversities,
    required this.getStudyfields,
  }) : super(UniversityStudyfieldInitial()) {
    on<LoadUniversitiesAndStudyfields>(_onLoadUniversitiesAndStudyfields);
  }

  Future<void> _onLoadUniversitiesAndStudyfields(
      LoadUniversitiesAndStudyfields event,
      Emitter<UniversityStudyfieldState> emit,
      ) async {
    emit(UniversityStudyfieldLoading());
    try {
      final universities = await getUniversities(const GetUniversitiesParams());
      final studyfields = await getStudyfields(const GetStudyfieldsParams());

      emit(UniversitiesAndStudyfieldsLoaded(
        universities: universities,
        studyfields: studyfields,
      ));
    } catch (e) {
      emit(const UniversitiesAndStudyfieldsError(
        message: 'Failed to load universities and study fields',
      ));
    }
  }
}