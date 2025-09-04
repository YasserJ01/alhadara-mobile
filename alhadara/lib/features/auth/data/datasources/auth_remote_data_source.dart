// // // auth/data/datasources/auth_remote_data_source.dart
// // import 'package:alhadara/core/token.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import '../models/login_request_model.dart';
// // import '../models/register_request_model.dart';

// // abstract class AuthRemoteDataSource {
// //   Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request);

// //   Future<Map<String, dynamic>> register(RegisterRequestModel request);
// // }

// // class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
// //   final http.Client client;
// //   final String BaseURL = "http://192.168.1.9:8000"; //192.168.1.9

// //   AuthRemoteDataSourceImpl(this.client);

// //   @override
// //   Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request) async {
// //     final response = await client.post(
// //       Uri.parse('http://10.0.2.2:8000/api/auth/jwt/create/'),
// //       // Replace with your full API endpoint
// //       headers: {
// //         'accept': 'application/json',
// //         'Content-Type': 'application/json',
// //       },
// //       body: jsonEncode(request.toJson()),
// //     );
// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> jsonData = json.decode(response.body);
// //       String accessToken = jsonData['access'];
// //       Token.token = accessToken;
// //       print(Token.token);
// //       return jsonDecode(response.body) as Map<String, dynamic>;
// //     } else {
// //       print(response.body);
// //       throw Exception('Failed to login: ${response.statusCode}');
// //     }
// //   }

// //   @override
// //   Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
// //     final response = await client.post(
// //       Uri.parse('http://10.0.2.2:8000/api/auth/users/'),
// //       // Replace with your full API endpoint
// //       headers: {
// //         'accept': 'application/json',
// //         'Content-Type': 'application/json',
// //       },
// //       body: jsonEncode(request.toJson()),
// //     );

// //     if (response.statusCode == 201) {
// //       // Typically 201 for created resources
// //       return jsonDecode(response.body) as Map<String, dynamic>;
// //     } else {
// //       print(response.body);
// //       throw Exception('Failed to register: ${response.statusCode}');
// //     }
// //   }
// // }
// // auth/data/datasources/auth_remote_data_source.dart
// import 'package:alhadara/core/token.dart';
// import 'package:alhadara/errors/expections.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/login_request_model.dart';
// import '../models/register_request_model.dart';
// import '../models/captcha_response_model.dart';

// abstract class AuthRemoteDataSource {
//   Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request);
//   Future<Map<String, dynamic>> register(RegisterRequestModel request);
//   Future<CaptchaResponseModel> getCaptcha();
//     Future<bool> verifyCaptcha(String key, String answer);

// }

// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final http.Client client;
//   final String BaseURL = "http://192.168.1.9:8000"; //192.168.1.9

//   AuthRemoteDataSourceImpl(this.client);

//   @override
//   Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request) async {
//     final response = await client.post(
//       Uri.parse('http://10.0.2.2:8000/api/auth/jwt/create/'),
//       headers: {
//         'accept': 'application/json',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(request.toJson()),
//     );
//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonData = json.decode(response.body);
//       String accessToken = jsonData['access'];
//       Token.token = accessToken;
//       print(Token.token);
//       return jsonDecode(response.body) as Map<String, dynamic>;
//     } else {
//       print(response.body);
//       throw Exception('Failed to login: ${response.statusCode}');
//     }
//   }

//   @override
//   Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
//     final response = await client.post(
//       Uri.parse('http://10.0.2.2:8000/api/auth/users/'),
//       headers: {
//         'accept': 'application/json',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(request.toJson()),
//     );

//     if (response.statusCode == 201) {
//       return jsonDecode(response.body) as Map<String, dynamic>;
//     } else {
//       print(response.body);
//       throw Exception('Failed to register: ${response.statusCode}');
//     }
//   }

//   @override
//   Future<CaptchaResponseModel> getCaptcha() async {
//     final response = await client.get(
//       Uri.parse('http://10.0.2.2:8000/api/core/api/captcha/'),
//       headers: {
//         'accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return CaptchaResponseModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to get CAPTCHA: ${response.statusCode}');
//     }
//   }

//   @override
// Future<bool> verifyCaptcha(String key, String answer) async {
//   final response = await client.post(
//     Uri.parse('http://10.0.2.2:8000/api/core/api/captcha/verify/'),
//     headers: {
//       'accept': 'application/json',
//       'Content-Type': 'application/json',
//     },
//     body: json.encode({
//       'key': key,
//       'answer': answer,
//     }),
//   );

//   print("Sent captcha verify => key: $key, answer: $answer");
//   print("Response => ${response.body}");

//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     return responseData['valid'] ?? false;
//   } else {
//     print('Captcha verify error: ${response.body}');
//     throw Exception('Failed to verify CAPTCHA: ${response.statusCode}');
//   }
// }

// }
// auth/data/datasources/auth_remote_data_source.dart
import 'package:alhadara/core/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/captcha_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request);
  Future<Map<String, dynamic>> register(RegisterRequestModel request);
  Future<CaptchaResponseModel> getCaptcha();
  Future<bool> verifyCaptcha(String key, String answer);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:8000"; // emulator loopback

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> loginWithPhone(LoginRequestModel request) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/auth/jwt/create/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final accessToken = jsonData['access'];
      Token.token = accessToken;
      return jsonData as Map<String, dynamic>;
    } else {
      throw Exception('Login failed. Please check your credentials.');
    }
  }

  @override
  Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/auth/users/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Registration failed. Please check your input.');
    }
  }

  @override
  Future<CaptchaResponseModel> getCaptcha() async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/core/api/captcha/'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return CaptchaResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load CAPTCHA. Please try again.');
    }
  }

@override
Future<bool> verifyCaptcha(String key, String answer) async {
  final response = await client.post(
    Uri.parse('$baseUrl/api/core/api/captcha/verify/'),
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'key': key,
      'answer': answer,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData['valid'] ?? false; // true or false
  } else {
    // بدل ما نرمي Exception، نرجع false
    return false;
  }
}

}
