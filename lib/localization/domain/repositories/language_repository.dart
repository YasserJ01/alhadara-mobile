// lib/domain/repositories/language_repository.dart
import 'package:dartz/dartz.dart';
import '../../../errors/failures.dart';
import '../entities/language.dart';

abstract class LanguageRepository {
  Future<Either<Failure, Language>> getCurrentLanguage();
  Future<Either<Failure, void>> saveLanguage(Language language);
  Future<Either<Failure, void>> clearLanguage();
}