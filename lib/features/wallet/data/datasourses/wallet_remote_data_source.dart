import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/core/network/api_client.dart';

import '../../../../core/token.dart';

abstract class WalletRemoteDataSource {
  Future<List<Map<String, dynamic>>> getWallet();

  Future<List<Map<String, dynamic>>> getTransactions();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;

  static const baseUrl = 'http://10.0.2.2:8000/api/core/wallets/';

  WalletRemoteDataSourceImpl(this.client, this.apiClient);

  @override
  Future<List<Map<String, dynamic>>> getWallet() async {
    // final response = await client.get(
    //     Uri.parse('http://10.0.2.2:8000/api/core/wallets/'),
    //     headers: {'Authorization': 'JWT ${Token.token}'});
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/core/wallets/',
    );
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
    // final response = await client.get(
    //   Uri.parse('http://10.0.2.2:8000/api/core/transactions/'),
    //   headers: {'Authorization': 'JWT ${Token.token}'},
    // );
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/core/transactions/',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print (data);

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
