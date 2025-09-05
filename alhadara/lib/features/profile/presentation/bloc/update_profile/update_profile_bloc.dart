// presentation/bloc/update_profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/create_profile_request.dart';
import '../../../domain/usecases/update_profile.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfile updateProfile;

  UpdateProfileBloc({
    required this.updateProfile,
  }) : super(UpdateProfileInitial()) {
    on<UpdateProfileSubmitted>(_onUpdateProfileSubmitted);
  }

  Future<void> _onUpdateProfileSubmitted(
    UpdateProfileSubmitted event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    try {
      await updateProfile(UpdateProfileParams(
        profileId: event.profileId,
        request: event.request,
      ));
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError(message: 'Failed to update profile'));
    }
  }
}