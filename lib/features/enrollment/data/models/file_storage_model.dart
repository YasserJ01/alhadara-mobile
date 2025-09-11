// lib/features/news_feed/data/models/file_storage_model.dart
import 'package:equatable/equatable.dart';

class FileStorageModel extends Equatable {
  final int id;
  final String telegramFileId;
  final String telegramDownloadLink;
  final String file;
  final DateTime uploadedAt;

  const FileStorageModel({
    required this.id,
    required this.telegramFileId,
    required this.telegramDownloadLink,
    required this.file,
    required this.uploadedAt,
  });

  factory FileStorageModel.fromJson(Map<String, dynamic> json) {
    return FileStorageModel(
      id: json['id'] as int,
      telegramFileId: json['telegram_file_id'] as String,
      telegramDownloadLink: json['telegram_download_link'] as String,
      file: json['file'] as String,
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'telegram_file_id': telegramFileId,
      'telegram_download_link': telegramDownloadLink,
      'file': file,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    telegramFileId,
    telegramDownloadLink,
    file,
    uploadedAt,
  ];
}