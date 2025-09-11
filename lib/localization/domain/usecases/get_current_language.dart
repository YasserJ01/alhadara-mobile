// lib/domain/usecases/get_current_language.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/usecases/usecase.dart';
import '../../../errors/failures.dart';
import '../entities/language.dart';
import '../repositories/language_repository.dart';


@injectable
class GetCurrentLanguage implements UseCase<Language, NoParams> {
  final LanguageRepository repository;

  GetCurrentLanguage(this.repository);

  @override
  Future<Either<Failure, Language>> call(NoParams params) async {
    return await repository.getCurrentLanguage();
  }
}