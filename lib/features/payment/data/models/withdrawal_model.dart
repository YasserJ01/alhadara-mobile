// data/models/withdrawal_model.dart
import 'package:equatable/equatable.dart';

class WithdrawalModel extends Equatable {
  final int id;
  final String amount;
  final String requestedAt;
  final String pickupDatetime;
  final String status;
  final String? handledAt;

  const WithdrawalModel({
    required this.id,
    required this.amount,
    required this.requestedAt,
    required this.pickupDatetime,
    required this.status,
    this.handledAt,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalModel(
      id: json['id'],
      amount: json['amount'],
      requestedAt: json['requested_at'],
      pickupDatetime: json['pickup_datetime'],
      status: json['status'],
      handledAt: json['handled_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'requested_at': requestedAt,
      'pickup_datetime': pickupDatetime,
      'status': status,
      'handled_at': handledAt,
    };
  }

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