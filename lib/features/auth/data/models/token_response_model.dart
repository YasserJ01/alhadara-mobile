// auth/data/models/token_response_model.dart
class TokenResponseModel {
  final String access;
  final String refresh;

  TokenResponseModel({
    required this.access,
    required this.refresh,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      access: json['access'],
      refresh: json['refresh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
}