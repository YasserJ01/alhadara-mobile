import '../repositories/interest_repository.dart';

class SaveUserInterestsUseCase {
  final InterestRepository repository;

  SaveUserInterestsUseCase({required this.repository});

  Future<void> call(int profileId, int interestId, int intensity) async {
    return await repository.saveUserInterests(profileId, interestId, intensity);
  }
}