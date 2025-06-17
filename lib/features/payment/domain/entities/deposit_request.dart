// domain/entities/deposit_request.dart
import 'package:equatable/equatable.dart';

class DepositRequest extends Equatable {
  final int id;
  final String screenshotPath;
  final int depositMethodId;
  final String transactionNumber;
  final double amount;
  final String status;
  final String createdAt;

  const DepositRequest({
    required this.id,
    required this.screenshotPath,
    required this.depositMethodId,
    required this.transactionNumber,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

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