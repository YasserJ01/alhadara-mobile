// features/profile/domain/usecases/get_universities.dart
import 'package:equatable/equatable.dart';

import '../../../../errors/failures.dart';
import '../entity/university.dart';
import '../repositories/profile_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}


class GetUniversitiesParams extends Equatable {
  const GetUniversitiesParams();

  @override
  List<Object> get props => [];
}

class GetUniversities implements UseCase<List<University>, GetUniversitiesParams> {
  final ProfileRepository repository;

  GetUniversities(this.repository);

  @override
  Future<List<University>> call(GetUniversitiesParams params) async {
    try {
      return await repository.getUniversities();
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw ServerFailure();
    }
  }
}