// lib/core/usecases/usecase.dart (if not exists)
import 'package:dartz/dartz.dart';
import '../../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
