// // lib/features/news_feed/data/models/news_feed_model.dart
// import 'package:equatable/equatable.dart';
// import '../../domain/entities/news_feed_entity.dart';
//
// class NewsFeedModel extends Equatable {
//   final int id;
//   final String? file;
//   final String? image;
//   final String type;
//   final String title;
//   final String content;
//   final DateTime createdAt;
//   final int scheduleSlot;
//   final int? author;
//   final int? relatedHomework;
//   final int? relatedQuiz;
//
//   const NewsFeedModel({
//     required this.id,
//     this.file,
//     this.image,
//     required this.type,
//     required this.title,
//     required this.content,
//     required this.createdAt,
//     required this.scheduleSlot,
//     this.author,
//     this.relatedHomework,
//     this.relatedQuiz,
//   });
//
//   factory NewsFeedModel.fromJson(Map<String, dynamic> json) {
//     return NewsFeedModel(
//       id: json['id'] as int,
//       file: json['file'] as String?,
//       image: json['image'] as String?,
//       type: json['type'] as String,
//       title: json['title'] as String,
//       content: json['content'] as String,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       scheduleSlot: json['schedule_slot'] as int,
//       author: json['author'] as int?,
//       relatedHomework: json['related_homework'] as int?,
//       relatedQuiz: json['related_quiz'] as int?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'file': file,
//       'image': image,
//       'type': type,
//       'title': title,
//       'content': content,
//       'created_at': createdAt.toIso8601String(),
//       'schedule_slot': scheduleSlot,
//       'author': author,
//       'related_homework': relatedHomework,
//       'related_quiz': relatedQuiz,
//     };
//   }
//
//   NewsFeedEntity toEntity() {
//     return NewsFeedEntity(
//       id: id,
//       file: file,
//       image: image,
//       type: NewsFeedType.fromString(type),
//       title: title,
//       content: content,
//       createdAt: createdAt,
//       scheduleSlot: scheduleSlot,
//       author: author,
//       relatedHomework: relatedHomework,
//       relatedQuiz: relatedQuiz,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     id,
//     file,
//     image,
//     type,
//     title,
//     content,
//     createdAt,
//     scheduleSlot,
//     author,
//     relatedHomework,
//     relatedQuiz,
//   ];
// }

// lib/features/news_feed/data/models/news_feed_model.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/news_feed_entity.dart';
import 'file_storage_model.dart';

class NewsFeedModel extends Equatable {
  final int id;
  final int? fileStorage;
  final FileStorageModel? fileStorageDetails;
  final String type;
  final String title;
  final String content;
  final String? image;
  final DateTime createdAt;
  final int scheduleSlot;
  final int? author;
  final int? relatedHomework;
  final int? relatedQuiz;

  const NewsFeedModel({
    required this.id,
    this.fileStorage,
    this.fileStorageDetails,
    required this.type,
    required this.title,
    required this.content,
    this.image,
    required this.createdAt,
    required this.scheduleSlot,
    this.author,
    this.relatedHomework,
    this.relatedQuiz,
  });

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) {
    return NewsFeedModel(
      id: json['id'] as int,
      fileStorage: json['file_storage'] as int?,
      fileStorageDetails: json['file_storage_details'] != null
          ? FileStorageModel.fromJson(json['file_storage_details'])
          : null,
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      scheduleSlot: json['schedule_slot'] as int,
      author: json['author'] as int?,
      relatedHomework: json['related_homework'] as int?,
      relatedQuiz: json['related_quiz'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_storage': fileStorage,
      'file_storage_details': fileStorageDetails?.toJson(),
      'type': type,
      'title': title,
      'content': content,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'schedule_slot': scheduleSlot,
      'author': author,
      'related_homework': relatedHomework,
      'related_quiz': relatedQuiz,
    };
  }

  NewsFeedEntity toEntity() {
    return NewsFeedEntity(
      id: id,
      fileStorageId: fileStorage,
      fileUrl: fileStorageDetails?.file,
      telegramFileId: fileStorageDetails?.telegramFileId,
      telegramDownloadLink: fileStorageDetails?.telegramDownloadLink,
      type: NewsFeedType.fromString(type),
      title: title,
      content: content,
      image: image,
      createdAt: createdAt,
      scheduleSlot: scheduleSlot,
      author: author,
      relatedHomework: relatedHomework,
      relatedQuiz: relatedQuiz,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fileStorage,
    fileStorageDetails,
    type,
    title,
    content,
    image,
    createdAt,
    scheduleSlot,
    author,
    relatedHomework,
    relatedQuiz,
  ];
}
