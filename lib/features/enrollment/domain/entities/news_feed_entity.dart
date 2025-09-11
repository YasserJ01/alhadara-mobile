// // lib/features/news_feed/domain/entities/news_feed_entity.dart
// import 'package:equatable/equatable.dart';
//
// enum NewsFeedType {
//   homework,
//   message,
//   image,
//   file,
//   quiz;
//
//   static NewsFeedType fromString(String type) {
//     switch (type.toLowerCase()) {
//       case 'homework':
//         return NewsFeedType.homework;
//       case 'message':
//         return NewsFeedType.message;
//       case 'image':
//         return NewsFeedType.image;
//       case 'file':
//         return NewsFeedType.file;
//       case 'quiz':
//         return NewsFeedType.quiz;
//       default:
//         return NewsFeedType.message;
//     }
//   }
//
//   String get displayName {
//     switch (this) {
//       case NewsFeedType.homework:
//         return 'Homework';
//       case NewsFeedType.message:
//         return 'Message';
//       case NewsFeedType.image:
//         return 'Image';
//       case NewsFeedType.file:
//         return 'File';
//       case NewsFeedType.quiz:
//         return 'Quiz';
//     }
//   }
// }
//
// class NewsFeedEntity extends Equatable {
//   final int id;
//   final String? file;
//   final String? image;
//   final NewsFeedType type;
//   final String title;
//   final String content;
//   final DateTime createdAt;
//   final int scheduleSlot;
//   final int? author;
//   final int? relatedHomework;
//   final int? relatedQuiz;
//
//   const NewsFeedEntity({
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
//   bool get hasFile => file != null && file!.isNotEmpty;
//   bool get hasImage => image != null && image!.isNotEmpty;
//   bool get isInteractive => type == NewsFeedType.homework || type == NewsFeedType.quiz;
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

// lib/features/news_feed/domain/entities/news_feed_entity.dart
import 'package:equatable/equatable.dart';

enum NewsFeedType {
  homework,
  message,
  image,
  file,
  quiz;

  static NewsFeedType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'homework':
        return NewsFeedType.homework;
      case 'message':
        return NewsFeedType.message;
      case 'image':
        return NewsFeedType.image;
      case 'file':
        return NewsFeedType.file;
      case 'quiz':
        return NewsFeedType.quiz;
      default:
        return NewsFeedType.message;
    }
  }

  String get displayName {
    switch (this) {
      case NewsFeedType.homework:
        return 'Homework';
      case NewsFeedType.message:
        return 'Message';
      case NewsFeedType.image:
        return 'Image';
      case NewsFeedType.file:
        return 'File';
      case NewsFeedType.quiz:
        return 'Quiz';
    }
  }
}

class NewsFeedEntity extends Equatable {
  final int id;
  final int? fileStorageId;
  final String? fileUrl;
  final String? telegramFileId;
  final String? telegramDownloadLink;
  final NewsFeedType type;
  final String title;
  final String content;
  final String? image;
  final DateTime createdAt;
  final int scheduleSlot;
  final int? author;
  final int? relatedHomework;
  final int? relatedQuiz;

  const NewsFeedEntity({
    required this.id,
    this.fileStorageId,
    this.fileUrl,
    this.telegramFileId,
    this.telegramDownloadLink,
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

  bool get hasFile => fileUrl != null && fileUrl!.isNotEmpty;
  bool get hasImage => image != null && image!.isNotEmpty;
  bool get isInteractive => type == NewsFeedType.homework || type == NewsFeedType.quiz;
  bool get hasTelegramFile => telegramFileId != null && telegramFileId!.isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    fileStorageId,
    fileUrl,
    telegramFileId,
    telegramDownloadLink,
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