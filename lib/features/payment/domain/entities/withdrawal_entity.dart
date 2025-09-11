import 'package:equatable/equatable.dart';

class WithdrawalEntity extends Equatable {
  final int id;
  final String amount;
  final String requestedAt;
  final String pickupDatetime;
  final String status;
  final String? handledAt;

  const WithdrawalEntity({
    required this.id,
    required this.amount,
    required this.requestedAt,
    required this.pickupDatetime,
    required this.status,
    this.handledAt,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        requestedAt,
        pickupDatetime,
        status,
        handledAt,
      ];
}