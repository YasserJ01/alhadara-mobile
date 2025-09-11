// data/repositories/payment_repository_impl.dart
import 'dart:io';
import '../../../../errors/failures.dart';
import '../../domain/entities/deposit_method_entity.dart';
import '../../domain/entities/deposit_request.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';
import '../../domain/entities/withdrawal_entity.dart';


class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<DepositRequest> createDepositRequest({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  }) async {
    try {
      final depositRequestModel = await remoteDataSource.createDepositRequest(
        screenshotFile: screenshotFile,
        depositMethodId: depositMethodId,
        transactionNumber: transactionNumber,
        amount: amount,
      );

      return DepositRequest(
        id: depositRequestModel.id,
        screenshotPath: depositRequestModel.screenshotPath,
        depositMethodId: depositRequestModel.depositMethodId,
        transactionNumber: depositRequestModel.transactionNumber,
        amount: depositRequestModel.amount,
        status: depositRequestModel.status,
        createdAt: depositRequestModel.createdAt,
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure();
    }
  }

  @override
  Future<List<DepositMethodEntity>> getDepositMethods() async {
    try {
      final models = await remoteDataSource.getDepositMethods();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure();
    }
  }
  @override
  Future<WithdrawalEntity> createWithdrawalRequest({
    required double amount,
    required String pickupDatetime,
  }) async {
    try {
      final withdrawalModel = await remoteDataSource.createWithdrawalRequest(
        amount: amount,
        pickupDatetime: pickupDatetime,
      );

      return WithdrawalEntity(
        id: withdrawalModel.id,
        amount: withdrawalModel.amount,
        requestedAt: withdrawalModel.requestedAt,
        pickupDatetime: withdrawalModel.pickupDatetime,
        status: withdrawalModel.status,
        handledAt: withdrawalModel.handledAt,
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure();
    }
  }
}
