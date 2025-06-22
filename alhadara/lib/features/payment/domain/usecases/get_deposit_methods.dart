// // // In domain/usecases/get_deposit_methods.dart
// // import 'package:alhadara/features/payment/depositmethod/data/models/deposit_method_model.dart';
// // import 'package:alhadara/features/payment/depositmethod/domain/repositories/deposit_method_repository.dart';

// // class GetDepositMethods {
// //   final PaymentRepository repository;

// //   GetDepositMethods(this.repository); // Positional parameter

// //   Future<List<DepositMethodModel>> call() async {
// //     return await repository.getDepositMethods();
// //   }
// // }
// // domain/usecases/get_deposit_methods.dart
// import 'package:alhadara/features/payment/depositmethod/domain/entities/deposit_method_entity.dart';
// import 'package:alhadara/features/payment/depositmethod/domain/repositories/deposit_method_repository.dart';

// class GetDepositMethods {
//   final DepositMethodRepository repository;

//   GetDepositMethods(this.repository);

//   Future<Either<DepositMethodFailure, List<DepositMethodEntity>>> call() async {
//     try {
//       final methods = await repository.getDepositMethods();
//       return Right(methods);
//     } on ServerFailure {
//       return Left(ServerFailure());
//     }
//   }
// }
// domain/usecases/get_deposit_methods.dart
import '../entities/deposit_method_entity.dart';
import '../repositories/payment_repository.dart';

class GetDepositMethods {
  final PaymentRepository repository;

  GetDepositMethods(this.repository);

  Future<List<DepositMethodEntity>> call() async {
    return await repository.getDepositMethods();
  }
}