// import 'package:alhadara/features/payment/depositmethod/data/datasources/deposit_method_remote_data_source.dart';
// import 'package:alhadara/features/payment/depositmethod/data/models/deposit_method_model.dart';
// import 'package:alhadara/features/payment/depositmethod/domain/repositories/payment_repository.dart';

// class PaymentRepositoryImpl implements PaymentRepository {
//   final PaymentRemoteDataSource remoteDataSource;

//   PaymentRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<List<DepositMethodModel>> getDepositMethods() async {
//     try {
//       final methods = await remoteDataSource.getDepositMethods();
//       print('Repository received methods: $methods'); // Debug line
//       return methods;
//     } catch (e) {
//       print('Repository error: $e'); // Debug line
//       throw e;
//     }
//   }
// }// data/repositories/deposit_method_repository_impl.dart
import 'package:alhadara/errors/failures.dart';
import 'package:alhadara/features/payment/depositmethod/data/datasources/deposit_method_remote_data_source.dart';
import 'package:alhadara/features/payment/depositmethod/domain/entities/deposit_method_entity.dart';
import 'package:alhadara/features/payment/depositmethod/domain/repositories/deposit_method_repository.dart';

class DepositMethodRepositoryImpl implements DepositMethodRepository {
  final DepositMethodRemoteDataSource remoteDataSource;

  DepositMethodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DepositMethodEntity>> getDepositMethods() async {
    try {
      final models = await remoteDataSource.getDepositMethods();
      return models.map((model) => model.toEntity()).toList();
    } on ServerException {
      throw ServerFailure();
    }
  }
}