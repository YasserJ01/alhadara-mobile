// // core/services/biometric_service.dart
// import 'package:local_auth/local_auth.dart';
// import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;
//
// class BiometricService {
//   static final LocalAuthentication _localAuth = LocalAuthentication();
//
//   static Future<bool> _checkFragmentActivity() async {
//     try {
//       // Try to check biometric availability - this will fail if not in FragmentActivity
//       await _localAuth.canCheckBiometrics;
//       return true;
//     } catch (e) {
//       print('Not in FragmentActivity context: $e');
//       return false;
//     }
//   }
//
//   // Check if biometric authentication is available
//   static Future<bool> isBiometricAvailable() async {
//     try {
//       final bool isAvailable = await _localAuth.canCheckBiometrics;
//       final bool isDeviceSupported = await _localAuth.isDeviceSupported();
//       return isAvailable && isDeviceSupported;
//     } catch (e) {
//       print('Error checking biometric availability: $e');
//       return false;
//     }
//   }
//
//   // Get available biometric types
//   static Future<List<BiometricType>> getAvailableBiometrics() async {
//     try {
//       return await _localAuth.getAvailableBiometrics();
//     } catch (e) {
//       print('Error getting available biometrics: $e');
//       return [];
//     }
//   }
//
//   // Enhanced authenticate method with detailed error handling
//   static Future<BiometricAuthResult> authenticate({
//     required String reason,
//     bool biometricOnly = false,
//   }) async {
//     try {
//       // Check if we're in FragmentActivity context
//       final bool isFragmentActivity = await _checkFragmentActivity();
//       if (!isFragmentActivity) {
//         return BiometricAuthResult.error(
//             'Biometric authentication requires FragmentActivity. Please update your MainActivity to extend FlutterFragmentActivity.'
//         );
//       }
//
//       // First check if biometric is available
//       final bool isAvailable = await isBiometricAvailable();
//       if (!isAvailable) {
//         return BiometricAuthResult.notAvailable();
//       }
//
//       // Check if biometrics are enrolled
//       final biometrics = await getAvailableBiometrics();
//       if (biometrics.isEmpty) {
//         return BiometricAuthResult.notEnrolled();
//       }
//
//       final bool didAuthenticate = await _localAuth.authenticate(
//         authMessages: const [
//           AndroidAuthMessages(
//             signInTitle: 'Biometric Authentication',
//             cancelButton: 'Cancel',
//             goToSettingsButton: 'Settings',
//             goToSettingsDescription: 'Please set up biometric authentication',
//             biometricHint: 'Touch sensor',
//             biometricNotRecognized: 'Biometric not recognized. Try again.',
//             biometricRequiredTitle: 'Biometric Required',
//             biometricSuccess: 'Biometric authentication successful',
//             deviceCredentialsRequiredTitle: 'Device Credential Required',
//             deviceCredentialsSetupDescription: 'Please set up device credentials',
//           ),
//         ],
//         options: AuthenticationOptions(
//           biometricOnly: biometricOnly,
//           stickyAuth: true,
//           sensitiveTransaction: true,
//         ),
//         localizedReason: reason, // Make sure this is not empty
//       );
//
//       if (didAuthenticate) {
//         return BiometricAuthResult.success();
//       } else {
//         return BiometricAuthResult.userCancel();
//       }
//     } on Exception catch (e) {
//       print('Biometric authentication error: $e');
//
//       // Handle specific error types
//       final errorMessage = e.toString().toLowerCase();
//
//       if (errorMessage.contains('no_fragment_activity')) {
//         return BiometricAuthResult.error(
//             'Please update your Android MainActivity to extend FlutterFragmentActivity instead of FlutterActivity'
//         );
//       } else if (errorMessage.contains('not_available')) {
//         return BiometricAuthResult.notAvailable();
//       } else if (errorMessage.contains('not_enrolled')) {
//         return BiometricAuthResult.notEnrolled();
//       } else if (errorMessage.contains('locked_out')) {
//         return BiometricAuthResult.lockedOut();
//       } else if (errorMessage.contains('user_cancel') ||
//           errorMessage.contains('user_fallback')) {
//         return BiometricAuthResult.userCancel();
//       } else if (errorMessage.contains('too_many_requests')) {
//         return BiometricAuthResult.tooManyAttempts();
//       } else {
//         return BiometricAuthResult.error(e.toString());
//       }
//     }
//   }
//
//   // Simple authenticate method for backward compatibility
//   static Future<bool> authenticateSimple({
//     required String reason,
//     bool biometricOnly = false,
//   }) async {
//     final result = await authenticate(reason: reason, biometricOnly: biometricOnly);
//     return result.isSuccess;
//   }
//
//   // Get biometric type name for display
//   static String getBiometricTypeName(List<BiometricType> types) {
//     if (types.contains(BiometricType.face)) {
//       return 'Face ID';
//     } else if (types.contains(BiometricType.fingerprint)) {
//       return 'Fingerprint';
//     } else if (types.contains(BiometricType.iris)) {
//       return 'Iris';
//     } else if (types.contains(BiometricType.strong)) {
//       return 'Biometric';
//     }
//     return 'Biometric';
//   }
//
//   // Check if user has enrolled biometrics
//   static Future<bool> hasEnrolledBiometrics() async {
//     final biometrics = await getAvailableBiometrics();
//     return biometrics.isNotEmpty;
//   }
//
//   // Get user-friendly biometric status
//   static Future<BiometricStatus> getBiometricStatus() async {
//     try {
//       final isAvailable = await isBiometricAvailable();
//       if (!isAvailable) {
//         return BiometricStatus.notAvailable;
//       }
//
//       final biometrics = await getAvailableBiometrics();
//       if (biometrics.isEmpty) {
//         return BiometricStatus.notEnrolled;
//       }
//
//       return BiometricStatus.available;
//     } catch (e) {
//       return BiometricStatus.error;
//     }
//   }
// }
//
// // Result class for detailed biometric authentication results
// class BiometricAuthResult {
//   final bool isSuccess;
//   final BiometricAuthError? error;
//   final String? errorMessage;
//
//   const BiometricAuthResult._({
//     required this.isSuccess,
//     this.error,
//     this.errorMessage,
//   });
//
//   factory BiometricAuthResult.success() {
//     return const BiometricAuthResult._(isSuccess: true);
//   }
//
//   factory BiometricAuthResult.notAvailable() {
//     return const BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.notAvailable,
//       errorMessage: 'Biometric authentication is not available on this device',
//     );
//   }
//
//   factory BiometricAuthResult.notEnrolled() {
//     return const BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.notEnrolled,
//       errorMessage: 'No biometric credentials are enrolled on this device',
//     );
//   }
//
//   factory BiometricAuthResult.userCancel() {
//     return const BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.userCancel,
//       errorMessage: 'User cancelled biometric authentication',
//     );
//   }
//
//   factory BiometricAuthResult.lockedOut() {
//     return const BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.lockedOut,
//       errorMessage: 'Biometric authentication is temporarily locked. Try again later.',
//     );
//   }
//
//   factory BiometricAuthResult.tooManyAttempts() {
//     return const BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.tooManyAttempts,
//       errorMessage: 'Too many failed attempts. Please try again later.',
//     );
//   }
//
//   factory BiometricAuthResult.error(String message) {
//     return BiometricAuthResult._(
//       isSuccess: false,
//       error: BiometricAuthError.unknown,
//       errorMessage: message,
//     );
//   }
//
//   String get userFriendlyMessage {
//     switch (error) {
//       case BiometricAuthError.notAvailable:
//         return 'Biometric login is not available on your device';
//       case BiometricAuthError.notEnrolled:
//         return 'Please set up biometric authentication in your device settings first';
//       case BiometricAuthError.userCancel:
//         return 'Authentication was cancelled';
//       case BiometricAuthError.lockedOut:
//         return 'Biometric authentication is temporarily disabled. Please try again later or use your device PIN';
//       case BiometricAuthError.tooManyAttempts:
//         return 'Too many failed attempts. Please wait and try again';
//       case BiometricAuthError.unknown:
//       default:
//         return errorMessage ?? 'Biometric authentication failed';
//     }
//   }
// }
//
// enum BiometricAuthError {
//   notAvailable,
//   notEnrolled,
//   userCancel,
//   lockedOut,
//   tooManyAttempts,
//   unknown,
// }
//
// enum BiometricStatus {
//   available,
//   notAvailable,
//   notEnrolled,
//   error,
// }