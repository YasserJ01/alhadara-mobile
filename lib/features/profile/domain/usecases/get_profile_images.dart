import '../entity/profile_image.dart';
import '../repositories/profile_repository.dart';

class GetProfileImages {
  final ProfileRepository repository;

  GetProfileImages(this.repository);

  Future<List<ProfileImage>> call() async {
    return await repository.getProfileImages();
  }
}