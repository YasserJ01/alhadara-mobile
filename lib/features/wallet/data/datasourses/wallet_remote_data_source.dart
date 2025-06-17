import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/token.dart';

abstract class WalletRemoteDataSource {
  Future<List<Map<String, dynamic>>> getWallet();
    Future<List<Map<String, dynamic>>> getTransactions();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final http.Client client;
  static const baseUrl = 'http://10.0.2.2:8000/api/core/wallets/';

  WalletRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getWallet() async {
    final response = await client.get(
        Uri.parse('http://10.0.2.2:8000/api/core/wallets/'),
        headers: {'Authorization': 'JWT ${Token.token}'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
      throw FormatException('Invalid response format');
    } else {
      print('API Response: ${response.body}');
      throw ServerException;
      
    }
  }
   @override
  Future<List<Map<String, dynamic>>> getTransactions() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/transactions/'),
      headers: {'Authorization': 'JWT ${Token.token}'},
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
      throw FormatException('Invalid response format');
    } else {
      throw ServerException();
    }
  }
}

class ServerException implements Exception {}
