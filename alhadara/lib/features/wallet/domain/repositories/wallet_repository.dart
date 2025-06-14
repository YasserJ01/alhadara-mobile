import 'package:alhadara/features/wallet/domain/entities/transaction_entity.dart';

import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<WalletEntity> getWallet();
   Future<List<TransactionEntity>> getTransactions();
}