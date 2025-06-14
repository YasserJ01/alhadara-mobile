import 'package:alhadara/features/wallet/data/datasourses/wallet_remote_data_source.dart';
import 'package:alhadara/features/wallet/data/models/transaction_model.dart';
import 'package:alhadara/features/wallet/domain/entities/transaction_entity.dart';

import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../models/wallet_model.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WalletEntity> getWallet() async {
    try {
      final response = await remoteDataSource.getWallet();
      if (response.isEmpty) {
        throw const WalletException(message: 'No wallet data found');
      }
      return WalletModel.fromJson(response.first).toEntity();
    } catch (e) {
      throw WalletException(message: 'Failed to load wallet: ${e.toString()}');
    }
  }
 @override
Future<List<TransactionEntity>> getTransactions() async {
  try {
    final response = await remoteDataSource.getTransactions();
    return response.map((json) => TransactionModel.fromJson(json).toEntity()).toList();
  } catch (e) {
    throw WalletException(message: 'Failed to load transactions: ${e.toString()}');
  }
}
}

class WalletException implements Exception {
  final String message;
  const WalletException({required this.message});
}
