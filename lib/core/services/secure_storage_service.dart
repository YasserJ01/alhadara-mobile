// core/services/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Keys for secure storage
  static const String _savedCredentialsKey = 'saved_credentials';
  static const String _keepSignedInKey = 'keep_signed_in';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _lastLoginPhoneKey = 'last_login_phone';

  // Save encrypted credentials
  static Future<void> saveCredentials({
    required String phone,
    required String password,
  }) async {
    final credentialsData = {
      'phone': phone,
      'password': _encryptPassword(password),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _storage.write(
      key: _savedCredentialsKey,
      value: jsonEncode(credentialsData),
    );
  }

  // Get saved credentials
  static Future<Map<String, String>?> getSavedCredentials() async {
    final credentialsJson = await _storage.read(key: _savedCredentialsKey);
    if (credentialsJson == null) return null;

    try {
      final credentialsData = jsonDecode(credentialsJson);
      return {
        'phone': credentialsData['phone'] as String,
        'password': _decryptPassword(credentialsData['password'] as String),
      };
    } catch (e) {
      // If decryption fails, clear corrupted data
      await clearSavedCredentials();
      return null;
    }
  }

  // Clear saved credentials
  static Future<void> clearSavedCredentials() async {
    await _storage.delete(key: _savedCredentialsKey);
  }

  // Check if credentials are saved
  static Future<bool> hasCredentialsSaved() async {
    final credentials = await _storage.read(key: _savedCredentialsKey);
    return credentials != null;
  }

  // Keep signed in preferences
  static Future<void> setKeepSignedIn(bool keepSignedIn) async {
    await _storage.write(
      key: _keepSignedInKey,
      value: keepSignedIn.toString(),
    );
  }

  static Future<bool> getKeepSignedIn() async {
    final value = await _storage.read(key: _keepSignedInKey);
    return value == 'true';
  }

  // Biometric authentication preferences
  static Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: _biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  static Future<bool> getBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  // Last login phone for convenience
  static Future<void> saveLastLoginPhone(String phone) async {
    await _storage.write(key: _lastLoginPhoneKey, value: phone);
  }

  static Future<String?> getLastLoginPhone() async {
    return await _storage.read(key: _lastLoginPhoneKey);
  }

  // Clear all user data (complete logout)
  static Future<void> clearAllUserData() async {
    await Future.wait([
      _storage.delete(key: _savedCredentialsKey),
      _storage.delete(key: _keepSignedInKey),
      _storage.delete(key: _biometricEnabledKey),
      _storage.delete(key: _lastLoginPhoneKey),
    ]);
  }

  // Simple encryption/decryption for passwords
  // In production, consider using more robust encryption libraries
  static String _encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    // This is a simple obfuscation. In production, use proper encryption
    return base64Encode(utf8.encode(password));
  }

  static String _decryptPassword(String encryptedPassword) {
    try {
      return utf8.decode(base64Decode(encryptedPassword));
    } catch (e) {
      throw Exception('Failed to decrypt password');
    }
  }
}