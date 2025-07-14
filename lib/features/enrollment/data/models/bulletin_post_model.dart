// models/bulletin_post_model.dart
class BulletinPostModel {
  final int scheduleSlotId;
  final String type;
  final String title;
  final String content;
  final String? file;
  final String? image;

  BulletinPostModel({
    required this.scheduleSlotId,
    required this.type,
    required this.title,
    required this.content,
    this.file,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'schedule_slot': scheduleSlotId,
      'type': type,
      'title': title,
      'content': content,
      'file': file,
      'image': image,
    };
  }
}