// domain/repositories/payment_repository.dart
import 'dart:io';
import '../entities/deposit_method_entity.dart';
import '../entities/deposit_request.dart';

abstract class PaymentRepository {
  Future<DepositRequest> createDepositRequest({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  });
  Future<List<DepositMethodEntity>> getDepositMethods();
}
