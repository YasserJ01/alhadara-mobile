import 'dart:convert';
import 'package:alhadara/core/token.dart';
import 'package:alhadara/features/payment/depositmethod/data/models/deposit_method_model.dart';
import 'package:http/http.dart'as http;

abstract class DepositMethodRemoteDataSource {
  Future<List<DepositMethodModel>> getDepositMethods();
}

class DepositMethodRemoteDataSourceImpl
    implements DepositMethodRemoteDataSource {
  final http.Client client;

  DepositMethodRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DepositMethodModel>> getDepositMethods() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/deposit-methods/'),
       headers: {'Authorization': 'JWT ${Token.token}'}
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => DepositMethodModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}

class ServerException implements Exception {}