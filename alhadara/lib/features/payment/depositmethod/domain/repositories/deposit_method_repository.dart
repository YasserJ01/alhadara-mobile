
import 'package:alhadara/features/payment/depositmethod/domain/entities/deposit_method_entity.dart';

abstract class DepositMethodRepository {
  Future<List<DepositMethodEntity>> getDepositMethods();
}