// States
import 'package:equatable/equatable.dart';

import '../../../domain/entities/bulletin_post_entity.dart';

abstract class BulletinPostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BulletinPostInitial extends BulletinPostState {}

class BulletinPostFormState extends BulletinPostState {
  final PostType type;
  final String title;
  final String content;
  final String? filePath;
  final String? imagePath;
  final bool isPublishing;
  final String? errorMessage;

  BulletinPostFormState({
    required this.type,
    required this.title,
    required this.content,
    this.filePath,
    this.imagePath,
    this.isPublishing = false,
    this.errorMessage,
  });

  bool get isFormValid {
    return title.isNotEmpty && content.isNotEmpty;
  }

  BulletinPostFormState copyWith({
    PostType? type,
    String? title,
    String? content,
    String? filePath,
    String? imagePath,
    bool? isPublishing,
    String? errorMessage,
  }) {
    return BulletinPostFormState(
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      filePath: filePath ?? this.filePath,
      imagePath: imagePath ?? this.imagePath,
      isPublishing: isPublishing ?? this.isPublishing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    type,
    title,
    content,
    filePath,
    imagePath,
    isPublishing,
    errorMessage,
  ];
}

class BulletinPostSuccess extends BulletinPostState {}
