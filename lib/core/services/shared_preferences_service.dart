// // core/services/shared_preferences_service.dart
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesService {
//   static SharedPreferences? _preferences;
//
//   // Keys for storage
//   static const String _accessTokenKey = 'access_token';
//   static const String _refreshTokenKey = 'refresh_token';
//   static const String _phoneKey = 'user_phone';
//   static const String _onboardingCompletedKey = 'onboarding_completed';
//
//   // Initialize SharedPreferences
//   static Future<void> init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }
//
//   // Ensure preferences are initialized
//   static SharedPreferences get preferences {
//     if (_preferences == null) {
//       throw Exception('SharedPreferences not initialized. Call init() first.');
//     }
//     return _preferences!;
//   }
//
//   // Token Management
//   static Future<bool> saveTokens({
//     required String accessToken,
//     required String refreshToken,
//     required String phone,
//   }) async {
//     try {
//       await Future.wait([
//         preferences.setString(_accessTokenKey, accessToken),
//         preferences.setString(_refreshTokenKey, refreshToken),
//         preferences.setString(_phoneKey, phone),
//       ]);
//       return true;
//     } catch (e) {
//       print('Error saving tokens: $e');
//       return false;
//     }
//   }
//
//   static String? getAccessToken() {
//     return preferences.getString(_accessTokenKey);
//   }
//
//   static String? getRefreshToken() {
//     return preferences.getString(_refreshTokenKey);
//   }
//
//   static String? getUserPhone() {
//     return preferences.getString(_phoneKey);
//   }
//
//   static bool isLoggedIn() {
//     final accessToken = getAccessToken();
//     return accessToken != null && accessToken.isNotEmpty;
//   }
//
//   static Future<bool> clearTokens() async {
//     try {
//       await Future.wait([
//         preferences.remove(_accessTokenKey),
//         preferences.remove(_refreshTokenKey),
//         preferences.remove(_phoneKey),
//       ]);
//       return true;
//     } catch (e) {
//       print('Error clearing tokens: $e');
//       return false;
//     }
//   }
//
//   // Onboarding Management
//   static Future<bool> setOnboardingCompleted(bool completed) async {
//     try {
//       await preferences.setBool(_onboardingCompletedKey, completed);
//       return true;
//     } catch (e) {
//       print('Error setting onboarding status: $e');
//       return false;
//     }
//   }
//
//   static bool isOnboardingCompleted() {
//     return preferences.getBool(_onboardingCompletedKey) ?? false;
//   }
//
//   static Future<bool> clearOnboardingStatus() async {
//     try {
//       await preferences.remove(_onboardingCompletedKey);
//       return true;
//     } catch (e) {
//       print('Error clearing onboarding status: $e');
//       return false;
//     }
//   }
//
//   // Clear all data (for logout)
//   static Future<bool> clearAll() async {
//     try {
//       await preferences.clear();
//       return true;
//     } catch (e) {
//       print('Error clearing all data: $e');
//       return false;
//     }
//   }
// }