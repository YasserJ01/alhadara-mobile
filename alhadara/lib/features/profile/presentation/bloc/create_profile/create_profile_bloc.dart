import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/create_profile_request.dart';
import '../../../domain/usecases/create_profile.dart';

//bloc/create_profile_bloc.dart
part 'create_profile_event.dart';
part 'create_profile_state.dart';
class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  final CreateProfile createProfile;

  CreateProfileBloc({
    required this.createProfile,
  }) : super(CreateProfileInitial()) {
    on<CreateProfileSubmitted>(_onCreateProfileSubmitted);
  }

  Future<void> _onCreateProfileSubmitted(
      CreateProfileSubmitted event,
      Emitter<CreateProfileState> emit,
      ) async {
    emit(CreateProfileLoading());
    try {
      final request = CreateProfileRequest(
        birthDate: event.birthDate,
        gender: event.gender,
        address: event.address,
        academicStatus: event.academicStatus,
        university: event.university,
        studyfield: event.studyfield,
      );

      final profileId = await createProfile(CreateProfileParams(request: request));
      emit(CreateProfileSuccess(profileId: profileId));
    } catch (e) {
      emit(const CreateProfileError(message: 'Failed to create profile'));
    }
  }
}