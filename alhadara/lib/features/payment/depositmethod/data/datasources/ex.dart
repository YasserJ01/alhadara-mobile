import 'dart:convert';

import 'package:alhadara/errors/expections.dart';
import 'package:alhadara/features/payment/depositmethod/data/models/deposit_method_model.dart';
import 'package:http/http.dart' as http;

abstract class DepositMethodRemoteDataSourece {
  Future<List<DepositMethodModel>> getDepositeMethode();
}

class DepositMethodRemoteDataSourceImp
    implements DepositMethodRemoteDataSourece {
  final http.Client client;
  DepositMethodRemoteDataSourceImp({required this.client});

  @override
  Future<List<DepositMethodModel>> getDepositeMethode() async {
    final Response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/deposit-methods/'),
    );
    if (Response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(Response.body);
      return jsonList.map((json) => DepositMethodModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
