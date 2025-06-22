// data/models/profile_image_model.dart
import 'package:equatable/equatable.dart';

class ProfileImageModel extends Equatable {
  final int id;
  final String image;

  const ProfileImageModel({
    required this.id,
    required this.image,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }

  @override
  List<Object> get props => [id, image];
}
