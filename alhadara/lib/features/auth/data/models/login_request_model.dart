// auth/data/models/login_request_model.dart
class LoginRequestModel {
  final String phone;
  final String password;

  LoginRequestModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password,
  };
}