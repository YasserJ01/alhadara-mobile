import '../../../../core/network/api_client.dart';
import '../../../../core/services/token_service.dart';
import '../../domain/entities/complaint_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/complaint_model.dart';


class ComplaintRemoteDataSource {
  // final ApiClient apiClient;
  final String baseUrl = 'https://optimum-kodiak-hardy.ngrok-free.app/api/complaints/complaints/';

  // ComplaintRemoteDataSourceImpl({required this.apiClient});

  Future<List<ComplaintModel>> getComplaints() async {
    // final response = await apiClient.authenticatedRequest(
    //   method: 'GET',
    //   endpoint: '/api/complaints/complaints/',
    // );
    final token = await TokenService.getAccessToken();

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'JWT $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ComplaintModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  Future<ComplaintModel> submitComplaint(Complaint complaint) async {
    // final response = await apiClient.authenticatedRequest(
    //   method: 'POST',
    //   endpoint: '/api/complaints/complaints/',
    //   body: json.encode(complaint.toJson()),
    // );
    final token = await TokenService.getAccessToken();

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT $token'
      },
      body: json.encode(complaint.toJson()),
    );

    if (response.statusCode == 201) {
      return ComplaintModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit complaint');
    }
  }
}
