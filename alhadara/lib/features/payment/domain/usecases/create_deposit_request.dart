// domain/usecases/create_deposit_request.dart
import 'dart:io';
import '../entities/deposit_request.dart';
import '../repositories/payment_repository.dart';

class CreateDepositRequest {
  final PaymentRepository repository;

  CreateDepositRequest(this.repository);

  Future<DepositRequest> call({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  }) async {
    return await repository.createDepositRequest(
      screenshotFile: screenshotFile,
      depositMethodId: depositMethodId,
      transactionNumber: transactionNumber,
      amount: amount,
    );
  }
}