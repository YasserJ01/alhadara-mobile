import 'dart:convert';

import 'package:alhadara/core/token.dart';
import 'package:alhadara/features/privet_lesson/data/models/private_lesson_request_model.dart';
import 'package:http/http.dart' as http;

abstract class PrivateLessonRequestRemoteDataSource {
  Future<PrivateLessonRequestModel> createPrivateLessonRequest({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  });
  Future<List<PrivateLessonRequestModel>> getPrivateLessonRequests();
  Future<PrivateLessonRequestModel> pickProposedOption({
    required int requestId,
    required int optionId,
  });
  Future<void> deletePrivateLessonRequest(int requestId);
}

class PrivateLessonRequestRemoteDataSourceImpl
    implements PrivateLessonRequestRemoteDataSource {
  final http.Client client;

  PrivateLessonRequestRemoteDataSourceImpl({required this.client});

  @override
  Future<PrivateLessonRequestModel> createPrivateLessonRequest({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  }) async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/lessons/private-lesson-requests/');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
      body: jsonEncode({
        'schedule_slot': scheduleSlot,
        'preferred_date': preferredDate,
        'preferred_time_from': preferredTimeFrom,
        'preferred_time_to': preferredTimeTo,
      }),
    );

    if (response.statusCode == 201) {
      return PrivateLessonRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create private lesson request');
    }
  }

  @override
  Future<List<PrivateLessonRequestModel>> getPrivateLessonRequests() async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/lessons/private-lesson-requests/');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => PrivateLessonRequestModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load private lesson requests');
    }
  }

  @override
  Future<PrivateLessonRequestModel> pickProposedOption({
    required int requestId,
    required int optionId,
  }) async {
    final url = Uri.parse(
      'http://10.0.2.2:8000/api/lessons/private-lesson-requests/$requestId/pick-option/',
    );

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
      body: jsonEncode({
        'option_id': optionId,
      }),
    );

    if (response.statusCode == 200) {
      return PrivateLessonRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to pick proposed option');
    }
  }

  @override
  Future<void> deletePrivateLessonRequest(int requestId) async {
    final url = Uri.parse(
      'http://10.0.2.2:8000/api/lessons/private-lesson-requests/$requestId/',
    );

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete request');
    }
  }
}
