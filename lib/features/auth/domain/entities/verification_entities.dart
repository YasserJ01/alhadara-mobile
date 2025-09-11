// domain/entities/verification_entities.dart
import 'package:equatable/equatable.dart';

class VerificationResult extends Equatable {
  final String token;
  final String deepLink;

  const VerificationResult({
    required this.token,
    required this.deepLink,
  });

  @override
  List<Object> get props => [token, deepLink];
}