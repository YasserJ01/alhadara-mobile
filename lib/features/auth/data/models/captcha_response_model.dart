// auth/data/models/captcha_response_model.dart
class CaptchaResponseModel {
  final String key;
  final String image;

  CaptchaResponseModel({
    required this.key,
    required this.image,
  });

  factory CaptchaResponseModel.fromJson(Map<String, dynamic> json) {
    return CaptchaResponseModel(
      key: json['key'],
      image: json['image'],
    );
  }
}