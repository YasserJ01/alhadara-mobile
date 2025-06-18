import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/expections.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/usecases/get_profile.dart';
import '../../../../../errors/failures.dart';

part 'profile_event.dart';

part 'profile_state.dart';
//lib/features/profile/presentation/bloc/profile_bloc.dart

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;

  ProfileBloc({required this.getProfile}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final profile = await getProfile(
        const GetProfileParams(),
      );
      emit(ProfileLoaded(profile));
    } on NotFoundFailure {
      emit(ProfileNotFound());
    } on Failure catch (e) {
      emit(ProfileError(e.toString()));
    } catch (e) {
      emit(
        const ProfileError('An unexpected error occurred'),
      );
    }
  }
// Future<void> _onLoadProfile(
//     LoadProfile event, Emitter<ProfileState> emit) async {
//   emit(ProfileLoading());
//
//   try {
//     final profile = await getProfile(GetProfileParams());
//     emit(ProfileLoaded(profile));
//   } on Failure catch (e) {
//     emit(ProfileError(e.toString()));
//   } catch (e) {
//     emit(ProfileError('An unexpected error occurred'));
//   }
// }
}
