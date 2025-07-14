// core/services/token_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Save tokens securely
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
    ]);
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Check if access token is expired
  static Future<bool> isAccessTokenExpired() async {
    final token = await getAccessToken();
    if (token == null) return true;

    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true; // If we can't decode it, consider it expired
    }
  }

  // Check if refresh token is expired
  static Future<bool> isRefreshTokenExpired() async {
    final token = await getRefreshToken();
    if (token == null) return true;

    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true;
    }
  }

  // Clear all tokens (logout)
  static Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    if (accessToken == null || refreshToken == null) return false;

    // If refresh token is expired, user needs to login again
    if (await isRefreshTokenExpired()) return false;

    return true;
  }
}