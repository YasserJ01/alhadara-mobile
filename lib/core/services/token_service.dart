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
  static const String _loginTimestampKey = 'login_timestamp';

  // Save tokens securely with timestamp
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _loginTimestampKey, value: timestamp),
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

  // Get login timestamp
  static Future<DateTime?> getLoginTimestamp() async {
    final timestampStr = await _storage.read(key: _loginTimestampKey);
    if (timestampStr == null) return null;

    try {
      final timestamp = int.parse(timestampStr);
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e) {
      return null;
    }
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
      _storage.delete(key: _loginTimestampKey),
    ]);
  }

  // Enhanced login check
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    if (accessToken == null || refreshToken == null) return false;

    // If refresh token is expired, user needs to login again
    if (await isRefreshTokenExpired()) {
      // Clean up expired tokens
      await clearTokens();
      return false;
    }

    return true;
  }

  // Check if user has a valid session (for keep signed in)
  static Future<bool> hasValidSession() async {
    final isLoggedIn = await TokenService.isLoggedIn();
    if (!isLoggedIn) return false;

    // Check if the login is not too old (optional security measure)
    final loginTime = await getLoginTimestamp();
    if (loginTime != null) {
      final daysSinceLogin = DateTime.now().difference(loginTime).inDays;
      // Consider session valid for 30 days maximum
      if (daysSinceLogin > 30) {
        await clearTokens();
        return false;
      }
    }

    return true;
  }

  // Get token expiry information for debugging
  static Future<Map<String, dynamic>> getTokenInfo() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final loginTime = await getLoginTimestamp();

    Map<String, dynamic> info = {
      'hasAccessToken': accessToken != null,
      'hasRefreshToken': refreshToken != null,
      'loginTime': loginTime?.toIso8601String(),
    };

    if (accessToken != null) {
      try {
        final accessExpiry = JwtDecoder.getExpirationDate(accessToken);
        info['accessTokenExpiry'] = accessExpiry.toIso8601String();
        info['accessTokenExpired'] = JwtDecoder.isExpired(accessToken);
      } catch (e) {
        info['accessTokenError'] = e.toString();
      }
    }

    if (refreshToken != null) {
      try {
        final refreshExpiry = JwtDecoder.getExpirationDate(refreshToken);
        info['refreshTokenExpiry'] = refreshExpiry.toIso8601String();
        info['refreshTokenExpired'] = JwtDecoder.isExpired(refreshToken);
      } catch (e) {
        info['refreshTokenError'] = e.toString();
      }
    }

    return info;
  }
}