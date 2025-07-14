// Events
import 'package:equatable/equatable.dart';

import '../../../domain/entities/bulletin_post_entity.dart';

abstract class BulletinPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostTypeChanged extends BulletinPostEvent {
  final PostType type;
  PostTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}

class TitleChanged extends BulletinPostEvent {
  final String title;
  TitleChanged(this.title);
  @override
  List<Object> get props => [title];
}

class ContentChanged extends BulletinPostEvent {
  final String content;
  ContentChanged(this.content);
  @override
  List<Object> get props => [content];
}

class FileSelected extends BulletinPostEvent {
  final String? filePath;
  FileSelected(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

class ImageSelected extends BulletinPostEvent {
  final String? imagePath;
  ImageSelected(this.imagePath);
  @override
  List<Object?> get props => [imagePath];
}

class PublishPost extends BulletinPostEvent {
  final int scheduleSlotId;
  PublishPost(this.scheduleSlotId);
  @override
  List<Object> get props => [scheduleSlotId];
}

class ResetForm extends BulletinPostEvent {}
