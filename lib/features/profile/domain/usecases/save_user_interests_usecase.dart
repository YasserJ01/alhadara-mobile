import 'package:project2/features/profile/domain/repositories/profile_repository.dart';

class SaveUserInterestsUseCase {
  final ProfileRepository repository;

  SaveUserInterestsUseCase({required this.repository});

  Future<void> call(int profileId, int interestId, int intensity) async {
    return await repository.saveUserInterests(profileId, interestId, intensity);
  }
}
