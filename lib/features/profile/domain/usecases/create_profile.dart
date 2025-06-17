import 'package:equatable/equatable.dart';

import '../../../../errors/failures.dart';
import '../entity/create_profile_request.dart';
import '../entity/profile.dart';
import '../repositories/profile_repository.dart';
//usecases/create_profile.dart
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class CreateProfileParams extends Equatable {
  final CreateProfileRequest request;

  const CreateProfileParams({required this.request});

  @override
  List<Object> get props => [request];
}

class CreateProfile implements UseCase<int, CreateProfileParams> {
  final ProfileRepository repository;

  CreateProfile(this.repository);

  @override
  Future<int> call(CreateProfileParams params) async {
    try {
      return await repository.createProfile(params.request);
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw ServerFailure();
    }
  }
}
