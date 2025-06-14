import 'package:alhadara/features/wallet/domain/entities/transaction_entity.dart';

class TransactionModel {
  final int id;
  final String referenceId;
  final String transactionType;
  final String amount;
  final String? senderName;
  final String receiverName;
  final String status;
  final String description;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.referenceId,
    required this.transactionType,
    required this.amount,
    this.senderName,
    required this.receiverName,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      referenceId: json['reference_id'],
      transactionType: json['transaction_type'],
      amount: json['amount'],
      senderName: json['sender_name'],
      receiverName: json['receiver_name'],
      status: json['status'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'reference_id': referenceId,
        'transaction_type': transactionType,
        'amount': amount,
        'sender_name': senderName,
        'receiver_name': receiverName,
        'status': status,
        'description': description,
        'created_at': createdAt.toIso8601String(),
      };
      TransactionEntity toEntity() {
  return TransactionEntity(
    id: id,
    referenceId: referenceId,
    transactionType: transactionType,
    amount: amount,
    senderName: senderName,
    receiverName: receiverName,
    status: status,
    description: description,
    createdAt: createdAt,
  );
}
}