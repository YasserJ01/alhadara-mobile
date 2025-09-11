// data/datasources/wishlist_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/core/network/api_client.dart';
import '../../../../core/token.dart';
import '../../../../errors/failures.dart';
import '../models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<void> toggleWishlist(int courseId);

  Future<List<WishlistModel>> getWishlists();
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;
  final String baseUrl = '/api/courses/wishlists';

  WishlistRemoteDataSourceImpl(this.client, this.apiClient);

  @override
  Future<void> toggleWishlist(int courseId) async {
    try {
      // final response = await client.post(
      //   Uri.parse('$baseUrl/toggle/$courseId/'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'JWT ${Token.token}', // Replace with your token class
      //   },
      // );
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '$baseUrl/toggle/$courseId/',
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<WishlistModel>> getWishlists() async {
    try {
      // final response = await client.get(
      //   Uri.parse('$baseUrl/'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'JWT ${Token.token}',
      //     // Replace with your token class
      //   },
      // );
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '$baseUrl/',
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
