import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/token.dart';
import '../../../../errors/failures.dart';
import '../models/deposit_method_model.dart';
import '../models/deposit_request_model.dart';


abstract class PaymentRemoteDataSource {
  Future<DepositRequestModel> createDepositRequest({
    required File screenshotFile,
    required int depositMethodId,
    required String transactionNumber,
    required double amount,
  });
  Future<List<DepositMethodModel>> getDepositMethods();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;

  PaymentRemoteDataSourceImpl(this.client);

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
        Uri.parse('http://10.0.2.2:8000/api/core/deposit-requests/'),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'JWT ${Token.token}',
        'accept': 'application/json',
      });

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
      throw ServerFailure();
    }
  }
}
