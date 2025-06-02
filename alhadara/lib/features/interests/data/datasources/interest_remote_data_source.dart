// // // data/datasources/interest_remote_data_source.dart
// import 'dart:convert';
// import 'package:alhadara/core/token.dart';
// import 'package:http/http.dart'as http;
// import 'package:alhadara/errors/expections.dart';

// // abstract class InterestRemoteDataSource {
// //   Future<List<dynamic>> getInterests();
// //   Future<void> addUserInterest(int profileId, int interestId, int intensity);
// // }

// // class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
// //   final http.Client client;

// //   InterestRemoteDataSourceImpl({required this.client});

// //   @override
// //   Future<List<dynamic>> getInterests() async {
// //     final response = await client.get(
// //       Uri.parse('http://10.0.2.2:8000/api/core/interests/'),
// //       headers: {'Authorization': 'JWT ${Token.token}'}
// //     );

// //     if (response.statusCode == 200) {
// //       return json.decode(response.body);
// //     } else {
// //       throw ServerException();
// //     }
// //   }

// //   @override
// //   Future<void> addUserInterest(int profileId, int interestId, int intensity) async {
// //     final response = await client.post(
// //       Uri.parse('http://10.0.2.2:8000/api/core/profiles/$profileId/add_interest/'),
// //       body: json.encode({
// //         'interest': interestId,
// //         'intensity': intensity,
// //       }),
// //       headers: {'Content-Type': 'application/json',
// //       'Authorization': 'JWT ${Token.token}'},
// //     );

// //     if (response.statusCode != 200 && response.statusCode != 201) {
// //       throw ServerException();
// //     }
// //   }
// // }
// // data/datasources/interest_remote_data_source.dart
// abstract class InterestRemoteDataSource {
//   Future<List<dynamic>> getInterests();
//   Future<void> addUserInterest({
//     required int profileId,
//     required int interestId,
//     required int intensity,
//   });
// }

// class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
//   final http.Client client;

//   InterestRemoteDataSourceImpl({required this.client});

//   @override
//   Future<List<dynamic>> getInterests() async {
//     final response = await client.get(
//       Uri.parse('http://10.0.2.2:8000/api/core/interests/'),
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<void> addUserInterest({
//     required int profileId,
//     required int interestId,
//     required int intensity,
//   }) async {
//     final response = await client.post(
//       Uri.parse('http://10.0.2.2:8000/api/core/profiles/$profileId/add_interest/'),
//       body: json.encode({
//         'interest': interestId,
//         'intensity': intensity,
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw ServerException();
//     }
//   }
// }
import 'dart:convert';
import 'package:alhadara/core/token.dart';
import 'package:http/http.dart' as http;

abstract class InterestRemoteDataSource {
  Future<List<Map<String, dynamic>>> getInterests();
  Future<void> saveUserInterests(int profileId, int interestId, int intensity);
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8000/api/core";

  InterestRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Map<String, dynamic>>> getInterests() async {
    final response = await client.get(Uri.parse('http://10.0.2.2:8000/api/core/interests/'),
    headers: {'Authorization': 'JWT ${Token.token}'}
    );
    
    
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load interests');
    }
  }

  @override
  Future<void> saveUserInterests(int profileId, int interestId, int intensity) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/profiles/$profileId/add_interest/'),
      body: json.encode({
        'interest': interestId,
        'intensity': intensity,
      }),
      headers: {'Content-Type': 'application/json',
      'Authorization': 'JWT ${Token.token}'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save user interests');
    }
  }
}