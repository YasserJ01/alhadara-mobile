// domain/usecases/update_profile.dart
import 'package:equatable/equatable.dart';
import '../../../../errors/failures.dart';
import '../entity/create_profile_request.dart';
import '../repositories/profile_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class UpdateProfileParams extends Equatable {
  final int profileId;
  final CreateProfileRequest request;

  const UpdateProfileParams({required this.profileId, required this.request});

  @override
  List<Object> get props => [profileId, request];
}

class UpdateProfile implements UseCase<void, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<void> call(UpdateProfileParams params) async {
    try {
      return await repository.updateProfile(params.profileId, params.request);
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw ServerFailure();
    }
  }
}