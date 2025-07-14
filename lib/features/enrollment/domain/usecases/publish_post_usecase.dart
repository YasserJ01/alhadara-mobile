// usecases/publish_post_usecase.dart
import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

import '../entities/bulletin_post_entity.dart';
import '../../data/models/bulletin_post_model.dart';

class PublishPostUseCase {
  final EnrollmentRepository repository;

  PublishPostUseCase({required this.repository});

  Future<void> call(BulletinPostEntity entity) async {
    final model = BulletinPostModel(
      scheduleSlotId: entity.scheduleSlotId,
      type: entity.type.value,
      title: entity.title,
      content: entity.content,
      file: entity.type == PostType.file ? entity.filePath : null,
      image: entity.type == PostType.image ? entity.imagePath : null,
    );

    await repository.publishPost(model);
  }
}