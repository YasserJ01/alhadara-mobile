// lib/domain/usecases/save_language.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/usecases/usecase.dart';
import '../../../errors/failures.dart';
import '../entities/language.dart';
import '../repositories/language_repository.dart';

@injectable
class SaveLanguage implements UseCase<void, SaveLanguageParams> {
  final LanguageRepository repository;

  SaveLanguage(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveLanguageParams params) async {
    return await repository.saveLanguage(params.language);
  }
}

class SaveLanguageParams {
  final Language language;

  SaveLanguageParams({required this.language});
}