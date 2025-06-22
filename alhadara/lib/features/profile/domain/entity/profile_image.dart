import 'package:equatable/equatable.dart';

class ProfileImage extends Equatable {
  final int id;
  final String image;

  const ProfileImage({
    required this.id,
    required this.image,
  });

  @override
  List<Object> get props => [id, image];
}
