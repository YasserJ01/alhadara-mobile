// auth/domain/entities/user_entity.dart
class UserEntity {
  final String phone;
  final String accessToken;
  final String refreshToken;

  UserEntity({
    required this.phone,
    required this.accessToken,
    required this.refreshToken,
  });
}
