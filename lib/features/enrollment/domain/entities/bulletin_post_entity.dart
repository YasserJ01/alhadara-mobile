// entities/bulletin_post_entity.dart
class BulletinPostEntity {
  final int scheduleSlotId;
  final PostType type;
  final String title;
  final String content;
  final String? filePath;
  final String? imagePath;

  BulletinPostEntity({
    required this.scheduleSlotId,
    required this.type,
    required this.title,
    required this.content,
    this.filePath,
    this.imagePath,
  });
}

enum PostType { message, file, image }

extension PostTypeExtension on PostType {
  String get value {
    switch (this) {
      case PostType.message:
        return 'message';
      case PostType.file:
        return 'file';
      case PostType.image:
        return 'image';
    }
  }
}