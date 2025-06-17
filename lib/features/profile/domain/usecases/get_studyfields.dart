// features/profile/domain/usecases/get_studyfields.dart
import 'package:equatable/equatable.dart';

import '../../../../errors/failures.dart';
import '../entity/studyfield.dart';
import '../repositories/profile_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}


class GetStudyfieldsParams extends Equatable {
  const GetStudyfieldsParams();

  @override
  List<Object> get props => [];
}

class GetStudyfields implements UseCase<List<Studyfield>, GetStudyfieldsParams> {
  final ProfileRepository repository;

  GetStudyfields(this.repository);

  @override
  Future<List<Studyfield>> call(GetStudyfieldsParams params) async {
    try {
      return await repository.getStudyfields();
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw ServerFailure();
    }
  }
}