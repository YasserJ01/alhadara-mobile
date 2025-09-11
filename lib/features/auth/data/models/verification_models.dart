// data/models/verification_models.dart
import 'package:equatable/equatable.dart';

class StartVerificationRequest extends Equatable {
  final String phone;

  const StartVerificationRequest({required this.phone});

  Map<String, dynamic> toJson() => {'phone': phone};

  @override
  List<Object> get props => [phone];
}

class StartVerificationResponse extends Equatable {
  final String token;
  final String deepLink;

  const StartVerificationResponse({
    required this.token,
    required this.deepLink,
  });

  factory StartVerificationResponse.fromJson(Map<String, dynamic> json) {
    return StartVerificationResponse(
      token: json['token'] as String,
      deepLink: json['deep_link'] as String,
    );
  }

  @override
  List<Object> get props => [token, deepLink];
}

class SubmitVerificationRequest extends Equatable {
  final String token;
  final String pin;

  const SubmitVerificationRequest({
    required this.token,
    required this.pin,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'pin': pin,
  };

  @override
  List<Object> get props => [token, pin];
}