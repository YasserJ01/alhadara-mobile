class TransactionEntity {
  final int id;
  final String referenceId;
  final String transactionType;
  final String amount;
  final String? senderName;
  final String receiverName;
  final String status;
  final String description;
  final DateTime createdAt;

  TransactionEntity({
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
}