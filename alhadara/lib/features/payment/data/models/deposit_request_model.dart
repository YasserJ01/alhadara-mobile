// data/models/deposit_request_model.dart
import 'package:equatable/equatable.dart';

class DepositRequestModel extends Equatable {
  final int id;
  final String screenshotPath;
  final int depositMethodId;
  final String transactionNumber;
  final double amount;
  final String status;
  final String createdAt;

  const DepositRequestModel({
    required this.id,
    required this.screenshotPath,
    required this.depositMethodId,
    required this.transactionNumber,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory DepositRequestModel.fromJson(Map<String, dynamic> json) {
    return DepositRequestModel(
      id: json['id'] ?? 0,
      screenshotPath: json['screenshot_path'] ?? '',
      depositMethodId: json['deposit_method_id'] ?? 0,
      transactionNumber: json['transaction_number'] ?? '',
      amount: _parseAmount(json['amount']),
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  static double _parseAmount(dynamic amount) {
    if (amount == null) return 0.0;
    if (amount is double) return amount;
    if (amount is int) return amount.toDouble();
    if (amount is String) {
      return double.tryParse(amount) ?? 0.0;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'screenshot_path': screenshotPath,
      'deposit_method_id': depositMethodId,
      'transaction_number': transactionNumber,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
    };
  }

  @override
  List<Object> get props => [
        id,
        screenshotPath,
        depositMethodId,
        transactionNumber,
        amount,
        status,
        createdAt,
      ];
}
