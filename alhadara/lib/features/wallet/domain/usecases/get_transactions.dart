import '../entities/transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetTransactions {
  final WalletRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionEntity>> call() async {
    return await repository.getTransactions();
  }
}
