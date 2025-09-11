// presentation/pages/start_verification_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/auth/presentation/pages/pin_verification_page.dart';
import '../../../../dependencies.dart';
import '../bloc/verification/verification_bloc.dart';
import '../bloc/verification/verification_event.dart';
import '../bloc/verification/verification_state.dart';
import 'package:url_launcher/url_launcher.dart';

class StartVerificationPage extends StatelessWidget {
  const StartVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
        centerTitle: true,
      ),
      body: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationStarted) {
            _showTelegramDialog(context, state.result.deepLink);
          } else if (state is VerificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return const _StartVerificationForm();
        },
      ),
    );
  }

  void _showTelegramDialog(BuildContext context, String deepLink) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Open Telegram'),
          content: const Text(
            'We\'ve sent a verification code to your Telegram bot. '
                'Tap "Open Telegram" to get your code, then return here to enter it.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => getIt<VerificationBloc>(),
                      child: PinVerificationPage(),
                    ),
                  ),
                );
              },
              child: const Text('Enter Code Manually'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _launchTelegram(deepLink);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => getIt<VerificationBloc>(),
                      child: PinVerificationPage(),
                    ),
                  ),
                );
              },
              child: const Text('Open Telegram'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchTelegram(String deepLink) async {
    try {
      final Uri telegramUrl = Uri.parse(deepLink);

      // Method 1: Try direct deep link
      bool launched = await launchUrl(
        telegramUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        // Method 2: Try with platform default
        launched = await launchUrl(
          telegramUrl,
          mode: LaunchMode.platformDefault,
        );
      }

      if (!launched) {
        // Method 3: Try Telegram app scheme
        final token = _extractTokenFromDeepLink(deepLink);
        final telegramAppUrl = Uri.parse('tg://resolve?domain=hadaravbot&start=$token');

        launched = await launchUrl(
          telegramAppUrl,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        // Method 4: Try opening Telegram web
        final token = _extractTokenFromDeepLink(deepLink);
        final telegramWebUrl = Uri.parse('https://web.telegram.org/a/#@hadaravbot?start=$token');

        launched = await launchUrl(
          telegramWebUrl,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        print(launched);
        // If all methods fail, show manual instructions
        // if (mounted) {
        //   _showTelegramError(context, deepLink);
        // }
      }
    } catch (e) {
      print(e);
      // If any exception occurs, show manual instructions
      // if (mounted) {
      //   _showTelegramError(context, deepLink);
      // }
    }
  }

  void _showTelegramError(BuildContext context, String deepLink) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Unable to Open Telegram'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('We couldn\'t automatically open Telegram. Please:'),
              const SizedBox(height: 8),
              const Text('1. Open Telegram manually'),
              const Text('2. Search for "hadaravbot"'),
              const Text('3. Start a chat with the bot'),
              const Text('4. Send the bot this token:'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SelectableText(
                  _extractTokenFromDeepLink(deepLink),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _extractTokenFromDeepLink(String deepLink) {
    final uri = Uri.parse(deepLink);
    return uri.queryParameters['start'] ?? 'Token not found';
  }
}

class _StartVerificationForm extends StatefulWidget {
  const _StartVerificationForm();

  @override
  State<_StartVerificationForm> createState() => _StartVerificationFormState();
}

class _StartVerificationFormState extends State<_StartVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.phone_android,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            const Text(
              'Enter your phone number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'We\'ll send a verification code to your Telegram bot',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '0988888888',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length < 10) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                final isLoading = state is VerificationLoading;

                return ElevatedButton(
                  onPressed: isLoading ? null : _startVerification,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text(
                    'Send Verification Code',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startVerification() {
    if (_formKey.currentState!.validate()) {
      context.read<VerificationBloc>().add(
        StartVerificationRequested(phone: _phoneController.text.trim()),
      );
    }
  }
}
// class StartVerificationPage extends StatelessWidget {
//   const StartVerificationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Phone Verification'),
//         centerTitle: true,
//       ),
//       body: BlocConsumer<VerificationBloc, VerificationState>(
//         listener: (context, state) {
//           if (state is VerificationStarted) {
//             _showTelegramDialog(context, state.result.deepLink);
//           } else if (state is VerificationError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return const _StartVerificationForm();
//         },
//       ),
//     );
//   }
//
//   void _showTelegramDialog(BuildContext context, String deepLink) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Open Telegram'),
//           content: const Text(
//             'We\'ve sent a verification code to your Telegram bot. '
//             'Tap "Open Telegram" to get your code, then return here to enter it.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const PinVerificationPage(),
//                   ),
//                 );
//               },
//               child: const Text('Enter Code Manually'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await _launchTelegram(deepLink);
//                 Navigator.of(dialogContext).pop();
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider(
//                       create: (context) => getIt<VerificationBloc>(),
//                       child: PinVerificationPage(),
//                     ),
//                   ),
//                 );
//               },
//               //   Navigator.of(context).push(
//               //     MaterialPageRoute(
//               //       builder: (context) => const PinVerificationPage(),
//               //     ),
//               //   );
//               // },
//               child: const Text('Open Telegram'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _launchTelegram(String deepLink) async {
//     final Uri url = Uri.parse(deepLink);
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     }
//   }
// }
//
// class _StartVerificationForm extends StatefulWidget {
//   const _StartVerificationForm();
//
//   @override
//   State<_StartVerificationForm> createState() => _StartVerificationFormState();
// }
//
// class _StartVerificationFormState extends State<_StartVerificationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Icon(
//               Icons.phone_android,
//               size: 80,
//               color: Colors.blue,
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Enter your phone number',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'We\'ll send a verification code to your Telegram bot',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             TextFormField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Phone Number',
//                 hintText: '0988888888',
//                 prefixIcon: Icon(Icons.phone),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter your phone number';
//                 }
//                 if (value.length < 10) {
//                   return 'Please enter a valid phone number';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 24),
//             BlocBuilder<VerificationBloc, VerificationState>(
//               builder: (context, state) {
//                 final isLoading = state is VerificationLoading;
//
//                 return ElevatedButton(
//                   onPressed: isLoading ? null : _startVerification,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Text(
//                           'Send Verification Code',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _startVerification() {
//     if (_formKey.currentState!.validate()) {
//       context.read<VerificationBloc>().add(
//             StartVerificationRequested(phone: _phoneController.text.trim()),
//           );
//     }
//   }
// }
