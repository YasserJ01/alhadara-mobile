import '../../../../core/network/api_client.dart';
import '../models/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/entities/feedback_entity.dart';

abstract class FeedbackRemoteDataSource {
  Future<FeedbackModel> submitFeedback(FeedbackEntity feedback);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;
  final String baseUrl = 'http://10.0.2.2:8000/api/feedback/submit/';

  FeedbackRemoteDataSourceImpl({required this.client, required this.apiClient});

  @override
  Future<FeedbackModel> submitFeedback(FeedbackEntity feedback) async {
    final response = await apiClient.authenticatedRequest(
      method: 'POST',
      endpoint: '/api/feedback/submit/',
      body: json.encode(feedback.toJson()),
    );
    // final response = await client.post(
    //   Uri.parse(baseUrl),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'JWT ${Token.token}'
    //   },
    //   body: json.encode(feedback.toJson()),
    // );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return FeedbackModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit feedback');
    }
  }
}
