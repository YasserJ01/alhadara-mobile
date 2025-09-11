import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/core/network/api_client.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/token.dart';
import '../../../../errors/failures.dart';
import '../models/deposit_method_model.dart';
import '../models/deposit_request_model.dart';
import '../models/withdrawal_model.dart';

abstract class PaymentRemoteDataSource {
  Future<DepositRequestModel> createDepositRequest({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  });

  Future<List<DepositMethodModel>> getDepositMethods();

  Future<WithdrawalModel> createWithdrawalRequest({
    required double amount,
    required String pickupDatetime,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;

  PaymentRemoteDataSourceImpl(this.client, this.apiClient);

  @override
  Future<DepositRequestModel> createDepositRequest({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        // Uri.parse('http://192.168.1.3:8000/api/core/deposit-requests/'),
        Uri.parse('https://optimum-kodiak-hardy.ngrok-free.app/api/core/deposit-requests/'),
      );

      // Add headers
      final accessToken = await TokenService.getAccessToken();
      print(accessToken);
      request.headers['Authorization'] = 'JWT $accessToken';

      // Add the screenshot file
      String fileName = screenshotFile.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'screenshot_path',
          screenshotFile.path,
          filename: fileName,
        ),
      );

      // Add form fields
      request.fields.addAll({
        'deposit_method': depositMethodId.toString(),
        'transaction_number': transactionNumber,
        'amount': amount.toString(),
      });

      print('Creating deposit request...');
      print('File: $fileName');
      print('Deposit Method ID: $depositMethodId');
      print('Transaction Number: $transactionNumber');
      print('Amount: $amount');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Deposit request response status: ${response.statusCode}');
      print('Deposit request response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return DepositRequestModel.fromJson(jsonData);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      if (e is ServerFailure) rethrow;
      print('Deposit request error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<DepositMethodModel>> getDepositMethods() async {
    // final response = await client.get(
    //     Uri.parse('http://10.0.2.2:8000/api/core/deposit-methods/'),
    //     headers: {'Authorization': 'JWT ${Token.token}'}
    // );
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/core/deposit-methods/',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DepositMethodModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<WithdrawalModel> createWithdrawalRequest({
    required double amount,
    required String pickupDatetime,
  }) async {
    try {
      final response  = await apiClient.authenticatedRequest(method: 'POST', endpoint: '/api/core/withdrawals/',body: json.encode({
        'amount': amount.toString(),
        'pickup_datetime': pickupDatetime,
      }),);
      // final response = await client.post(
      //   Uri.parse('http://10.0.2.2:8000/api/core/withdrawals/'),
      //   headers: {
      //     'Authorization': 'JWT ${Token.token}',
      //     'Content-Type': 'application/json',
      //   },
      //   body: json.encode({
      //     'amount': amount.toString(),
      //     'pickup_datetime': pickupDatetime,
      //   }),
      // );

      print('Withdrawal request response status: ${response.statusCode}');
      print('Withdrawal request response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return WithdrawalModel.fromJson(jsonData);
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      if (e is ServerFailure) rethrow;
      print('Withdrawal request error: $e');
      throw ServerFailure();
    }
  }
}
