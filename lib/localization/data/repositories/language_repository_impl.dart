// lib/data/repositories/language_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../errors/expections.dart';
import '../../../errors/failures.dart';
import '../../domain/entities/language.dart';
import '../../domain/repositories/language_repository.dart';
import '../datasources/language_local_data_source.dart';

@Injectable(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource localDataSource;

  LanguageRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Language>> getCurrentLanguage() async {
    try {
      final language = await localDataSource.getCurrentLanguage();
      return Right(language);
    } on LocalStorageException {
      return Left(LocalStorageFailure('Failed to get current language'));
    } catch (e) {
      return Left(LocalStorageFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveLanguage(Language language) async {
    try {
      await localDataSource.saveLanguage(language);
      return const Right(null);
    } on LocalStorageException {
      return Left(LocalStorageFailure('Failed to save language'));
    } catch (e) {
      return Left(LocalStorageFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearLanguage() async {
    try {
      await localDataSource.clearLanguage();
      return const Right(null);
    } on LocalStorageException {
      return Left(LocalStorageFailure('Failed to clear language'));
    } catch (e) {
      return Left(LocalStorageFailure('Unexpected error: ${e.toString()}'));
    }
  }
}