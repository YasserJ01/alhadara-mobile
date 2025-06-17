import 'package:equatable/equatable.dart';
import '../entity/profile.dart';
import '../repositories/profile_repository.dart';
import '../../../../errors/failures.dart';

//domain/usecases/get_profile.dart
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class GetProfileParams extends Equatable {

  const GetProfileParams();

  @override
  List<Object> get props => [];
}

class GetProfile implements UseCase<Profile, GetProfileParams> {
  final ProfileRepository repository;

  GetProfile(this.repository);

  @override
  Future<Profile> call(GetProfileParams params) async {
    try {
      return await repository.getProfile();
    } on Failure catch (e) {
      rethrow; // Re-throw specific failures
    } catch (e) {
      throw ServerFailure(); // Convert unexpected errors to ServerFailure
    }
  }
}