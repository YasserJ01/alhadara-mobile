// data/datasources/wishlist_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/token.dart';
import '../../../../errors/failures.dart';
import '../models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<void> toggleWishlist(int courseId);
  Future<List<WishlistModel>> getWishlists();
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'http://10.0.2.2:8000/api/courses/wishlists';

  WishlistRemoteDataSourceImpl({required this.client});

  @override
  Future<void> toggleWishlist(int courseId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/toggle/$courseId/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT ${Token.token}', // Replace with your token class
        },
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
      final response = await client.get(
        Uri.parse('$baseUrl/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT ${Token.token}', // Replace with your token class
        },
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