// // Create this widget to test biometric functionality
// // biometric_debug_widget.dart
// import 'package:flutter/material.dart';
//
// import 'biometric_service.dart';
//
// class BiometricDebugWidget extends StatefulWidget {
//   const BiometricDebugWidget({super.key});
//
//   @override
//   State<BiometricDebugWidget> createState() => _BiometricDebugWidgetState();
// }
//
// class _BiometricDebugWidgetState extends State<BiometricDebugWidget> {
//   String _debugInfo = 'Tap "Check Status" to begin';
//   bool _isLoading = false;
//
//   Future<void> _checkBiometricStatus() async {
//     setState(() {
//       _isLoading = true;
//       _debugInfo = 'Checking biometric status...';
//     });
//
//     try {
//       final isAvailable = await BiometricService.isBiometricAvailable();
//       final biometrics = await BiometricService.getAvailableBiometrics();
//       final hasEnrolled = await BiometricService.hasEnrolledBiometrics();
//       final status = await BiometricService.getBiometricStatus();
//
//       final info = StringBuffer();
//       info.writeln('=== BIOMETRIC STATUS ===');
//       info.writeln('Available: $isAvailable');
//       info.writeln('Has Enrolled: $hasEnrolled');
//       info.writeln('Status: $status');
//       info.writeln('Types: ${biometrics.map((e) => e.name).join(', ')}');
//       info.writeln('Count: ${biometrics.length}');
//
//       if (biometrics.isNotEmpty) {
//         info.writeln('Display Name: ${BiometricService.getBiometricTypeName(biometrics)}');
//       }
//
//       setState(() {
//         _debugInfo = info.toString();
//       });
//     } catch (e) {
//       setState(() {
//         _debugInfo = 'Error checking status: $e';
//       });
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _testBiometricAuth() async {
//     setState(() {
//       _isLoading = true;
//       _debugInfo = 'Testing biometric authentication...';
//     });
//
//     try {
//       final result = await BiometricService.authenticate(
//         reason: 'Test biometric authentication',
//         biometricOnly: false, // Allow fallback to PIN/Pattern
//       );
//
//       final info = StringBuffer();
//       info.writeln('=== AUTHENTICATION RESULT ===');
//       info.writeln('Success: ${result.isSuccess}');
//       if (!result.isSuccess) {
//         info.writeln('Error: ${result.error}');
//         info.writeln('Message: ${result.errorMessage}');
//         info.writeln('User Friendly: ${result.userFriendlyMessage}');
//       }
//
//       setState(() {
//         _debugInfo = info.toString();
//       });
//     } catch (e) {
//       setState(() {
//         _debugInfo = 'Authentication error: $e';
//       });
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _testBiometricOnlyAuth() async {
//     setState(() {
//       _isLoading = true;
//       _debugInfo = 'Testing biometric-only authentication...';
//     });
//
//     try {
//       final result = await BiometricService.authenticate(
//         reason: 'Test biometric-only authentication',
//         biometricOnly: true, // No fallback
//       );
//
//       final info = StringBuffer();
//       info.writeln('=== BIOMETRIC-ONLY RESULT ===');
//       info.writeln('Success: ${result.isSuccess}');
//       if (!result.isSuccess) {
//         info.writeln('Error: ${result.error}');
//         info.writeln('Message: ${result.errorMessage}');
//         info.writeln('User Friendly: ${result.userFriendlyMessage}');
//       }
//
//       setState(() {
//         _debugInfo = info.toString();
//       });
//     } catch (e) {
//       setState(() {
//         _debugInfo = 'Biometric-only error: $e';
//       });
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Biometric Debug'),
//         backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Debug Information',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.grey[300]!),
//                       ),
//                       child: Text(
//                         _debugInfo,
//                         style: const TextStyle(
//                           fontFamily: 'monospace',
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _isLoading ? null : _checkBiometricStatus,
//               icon: _isLoading
//                   ? const SizedBox(
//                 width: 16,
//                 height: 16,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Icon(Icons.info),
//               label: const Text('Check Biometric Status'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _isLoading ? null : _testBiometricAuth,
//               icon: _isLoading
//                   ? const SizedBox(
//                 width: 16,
//                 height: 16,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Icon(Icons.fingerprint),
//               label: const Text('Test Biometric Auth (with fallback)'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _isLoading ? null : _testBiometricOnlyAuth,
//               icon: _isLoading
//                   ? const SizedBox(
//                 width: 16,
//                 height: 16,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Icon(Icons.security),
//               label: const Text('Test Biometric Only (no fallback)'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Troubleshooting Tips:',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text('• Ensure biometric is set up in device settings'),
//                     Text('• Check app permissions for biometric access'),
//                     Text('• Try with fallback enabled first'),
//                     Text('• Test on physical device (not emulator)'),
//                     Text('• Check device lock screen security'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }