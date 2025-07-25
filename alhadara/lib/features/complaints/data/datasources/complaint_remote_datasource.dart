import 'package:alhadara/core/token.dart';
import 'package:alhadara/features/complaints/domain/entities/complaint_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/complaint_model.dart';

class ComplaintRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:8000/api/complaints/complaints/';

  Future<List<ComplaintModel>> getComplaints() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'JWT ${Token.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ComplaintModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  Future<ComplaintModel> submitComplaint(Complaint complaint) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
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
