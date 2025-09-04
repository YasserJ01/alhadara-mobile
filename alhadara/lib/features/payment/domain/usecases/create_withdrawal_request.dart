import 'package:alhadara/features/payment/domain/entities/withdrawal_entity.dart';
import 'package:alhadara/features/payment/domain/repositories/payment_repository.dart';

class CreateWithdrawalRequest {
  final PaymentRepository repository;

  CreateWithdrawalRequest(this.repository);

  Future<WithdrawalEntity> call({
    required double amount,
    required String pickupDatetime,
  }) async {
    return await repository.createWithdrawalRequest(
      amount: amount,
        pickupDatetime: pickupDatetime,
    );
  }
}