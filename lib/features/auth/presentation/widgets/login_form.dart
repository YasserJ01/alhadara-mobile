// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/auth_bloc.dart';
// import '../pages/register_page.dart';
//
// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});
//
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error)),
//           );
//         } else if (state is AuthSuccess) {
//           Navigator.pushReplacement(context, Container() as Route<Object?>);
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneController,
//               decoration: const InputDecoration(labelText: 'Phone Number'),
//               keyboardType: TextInputType.phone,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthLoading) {
//                   return const CircularProgressIndicator();
//                 }
//                 return ElevatedButton(
//                   onPressed: () {
//                     context.read<AuthBloc>().add(
//                           LoginWithPhoneRequested(
//                             _phoneController.text.trim(),
//                             _passwordController.text.trim(),
//                           ),
//                         );
//                   },
//                   child: const Text('Login'),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             // Inside LoginForm widget:
//             TextButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const RegisterPage()),
//               ),
//               child: const Text('Create an account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// auth/presentation/widgets/login_form.dart

// auth/presentation/widgets/login_form.dart

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/enrollment/presentation/bloc/lesson_combo/lesson_combo_bloc.dart';
import 'package:project2/features/profile/presentation/bloc/view_profile/profile_bloc.dart';
import 'package:project2/features/quiz/presentation/bloc/quiz_list/quiz_list_bloc.dart';
import 'package:project2/features/reset_password/presentation/pages/request_security_question_page.dart';
import 'package:project2/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../../core/utils/validators.dart';
import '../../../../dependencies.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../enrollment/presentation/bloc/homeworks/homework_bloc.dart';
import '../../../enrollment/presentation/bloc/lessons/lessons_bloc.dart';
import '../../../enrollment/presentation/pages/lessons_page.dart';
import '../../../enrollment/presentation/pages/news_feed_wrapper.dart';
import '../../../enrollment/presentation/pages/private_lesson_request_page.dart';
import '../../../enrollment/presentation/pages/teacher/bulletin_post_page.dart';
import '../../../enrollment/presentation/pages/teacher/create_lesson_combo_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../loyalty_points/presentation/pages/loyalty_points_page.dart';
import '../../../onboarding/bloc/onboarding_bloc.dart';
import '../../../onboarding/bloc/onboarding_events.dart';
import '../../../onboarding/screens/onboarding.dart';
import '../../../onboarding/screens/onboarding_screen.dart';
import '../../../payment/presentation/pages/deposit_request_page.dart';
import '../../../profile/presentation/bloc/create_profile/create_profile_bloc.dart';
import '../../../profile/presentation/bloc/profile_image/profile_image_bloc.dart';
import '../../../profile/presentation/pages/create_profile_basic_info_page.dart';
import '../../../profile/presentation/pages/profile_image_upload_page.dart';
import '../../../profile/presentation/pages/profile_images_display_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../quiz/presentation/bloc/quiz_attempt/quiz_attempt_bloc.dart';
import '../../../quiz/presentation/bloc/quiz_questions/quiz_questions_bloc.dart';
import '../../../quiz/presentation/pages/quiz_list_page.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';
import '../bloc/verification/verification_bloc.dart';
import '../pages/start_verification_page.dart';
import 'custom_register_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// class LoginFormContent extends StatefulWidget {
//   final VoidCallback? onSignUpPressed;
//
//   const LoginFormContent({super.key, this.onSignUpPressed});
//
//   @override
//   State<LoginFormContent> createState() => _LoginFormContentState();
// }
//
// class _LoginFormContentState extends State<LoginFormContent> {
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _showPassword = false;
//   bool _saveCredentials = false;
//   bool _keepSignedIn = false;
//   bool _biometricEnabled = false;
//   bool _biometricAvailable = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCredentials();
//     _checkBiometricAvailability();
//   }
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _loadSavedCredentials() {
//     context.read<AuthBloc>().add(LoadSavedCredentialsRequested());
//   }
//
//   void _checkBiometricAvailability() async {
//     final available = await BiometricService.isBiometricAvailable();
//     if (mounted) {
//       setState(() {
//         _biometricAvailable = available;
//       });
//     }
//   }
//
//   void _showBiometricLoginDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Biometric Login'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.fingerprint,
//               size: 64,
//               color: Theme.of(context).primaryColor,
//             ),
//             const SizedBox(height: 16),
//             const Text('Use your biometric authentication to login'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               context.read<AuthBloc>().add(
//                     const LoginWithSavedCredentialsRequested(
//                         useBiometric: true),
//                   );
//             },
//             child: const Text('Authenticate'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           AwesomeDialog(
//             context: context,
//             transitionAnimationDuration: const Duration(milliseconds: 500),
//             dialogType: DialogType.error,
//             animType: AnimType.bottomSlide,
//             headerAnimationLoop: false,
//             title: 'Error',
//             desc: state.error,
//             btnOkOnPress: () {},
//             buttonsBorderRadius: BorderRadius.circular(0),
//             btnOkColor: Colors.red,
//             buttonsTextStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//             ),
//           ).show();
//         } else if (state is AuthSuccess || state is AuthAuthenticated) {
//           Navigator.pop(context);
//
//           // Navigator.of(context).pushReplacement(
//           //   MaterialPageRoute(
//           //     builder: (context) {
//           //       return const PrivateLessonRequestPage(
//           //         scheduleSlotId: 281,
//           //       );
//           //     },
//           //   ),
//           // );
//           // Navigator.of(context).pushReplacement(
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<VerificationBloc>(),
//           //       child: const StartVerificationPage(),
//           //     ),
//           //   ),
//           // );
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) {
//                 return const HomePage();
//               },
//             ),
//           );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => const BulletinPostPage(scheduleSlotId: 281),
//           //   ),
//           // );
//         } else if (state is SavedCredentialsLoaded) {
//           setState(() {
//             _phoneController.text = state.phone;
//             _saveCredentials = state.hasPassword;
//             _biometricEnabled = state.biometricEnabled;
//             _biometricAvailable = state.biometricAvailable;
//           });
//         } else if (state is BiometricAuthenticationRequired) {
//           _showBiometricLoginDialog();
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(45),
//                 topRight: Radius.circular(45),
//               ),
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Color.fromRGBO(162, 12, 13, 1.0),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "let's get started",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromARGB(255, 148, 145, 146),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // Phone Number Field
//                   CustomRegisterTextField(
//                     controller: _phoneController,
//                     label: 'Phone Number',
//                     keyboardType: TextInputType.phone,
//                     validator: Validators.validateSyrianPhone,
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Password Field
//                   CustomRegisterTextField(
//                     controller: _passwordController,
//                     label: 'Password',
//                     obscureText: !_showPassword,
//                     keyboardType: TextInputType.text,
//                     validator: Validators.validatePassword,
//                     validateOnChange: true,
//                     suffixIcon: Icon(
//                       _showPassword ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onSuffixPressed: () =>
//                         setState(() => _showPassword = !_showPassword),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Security Options
//                   _buildSecurityOptions(),
//
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RequestSecurityQuestionPage(),
//                         ),
//                       ),
//                       child: const Text(
//                         "forgot password ?",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//
//                   // Login Button
//                   _buildLoginButton(),
//
//                   const SizedBox(height: 10),
//
//                   // Quick Login Options
//                   _buildQuickLoginOptions(),
//
//                   const SizedBox(height: 20),
//
//                   // Sign Up Link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Don\'t have an account ?',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (widget.onSignUpPressed != null) {
//                             widget.onSignUpPressed!();
//                           }
//                         },
//                         child: const Text(
//                           ' SIGN UP',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color.fromRGBO(162, 12, 13, 1.0),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.03),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSecurityOptions() {
//     return Column(
//       children: [
//         // Save Password Option
//         Row(
//           children: [
//             Checkbox(
//               value: _saveCredentials,
//               onChanged: (value) {
//                 setState(() {
//                   _saveCredentials = value ?? false;
//                   if (!_saveCredentials) {
//                     _biometricEnabled = false;
//                   }
//                 });
//               },
//               activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
//             ),
//             const Expanded(
//               child: Text(
//                 'Save my password securely',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color.fromARGB(255, 148, 145, 146),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         // Keep Signed In Option
//         Row(
//           children: [
//             Checkbox(
//               value: _keepSignedIn,
//               onChanged: (value) {
//                 setState(() {
//                   _keepSignedIn = value ?? false;
//                 });
//               },
//               activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
//             ),
//             const Expanded(
//               child: Text(
//                 'Keep me signed in',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color.fromARGB(255, 148, 145, 146),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         // Biometric Authentication Option
//         if (_biometricAvailable && _saveCredentials)
//           Row(
//             children: [
//               Checkbox(
//                 value: _biometricEnabled,
//                 onChanged: (value) {
//                   setState(() {
//                     _biometricEnabled = value ?? false;
//                   });
//                   context.read<AuthBloc>().add(
//                         UpdateBiometricPreferenceRequested(_biometricEnabled),
//                       );
//                 },
//                 activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
//               ),
//               Expanded(
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.fingerprint,
//                       size: 16,
//                       color: Color.fromARGB(255, 148, 145, 146),
//                     ),
//                     const SizedBox(width: 4),
//                     const Text(
//                       'Enable biometric login',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color.fromARGB(255, 148, 145, 146),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
//
//   Widget _buildLoginButton() {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthLoading) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Color.fromRGBO(162, 12, 13, 1.0),
//             ),
//           );
//         }
//         return SizedBox(
//           width: AppSizes.screenWidth(context),
//           height: AppSizes.screenHeight(context) * 0.07,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(1),
//               ),
//             ),
//             onPressed: () {
//               // Validate input before sending
//               if (_phoneController.text.trim().isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Please enter your phone number'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//                 return;
//               }
//
//               if (_passwordController.text.trim().isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Please enter your password'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//                 return;
//               }
//
//               context.read<AuthBloc>().add(
//                     LoginWithPhoneRequested(
//                       _phoneController.text.trim(),
//                       _passwordController.text.trim(),
//                       saveCredentials: _saveCredentials,
//                       keepSignedIn: _keepSignedIn,
//                     ),
//                   );
//             },
//             child: const Text(
//               'LOGIN',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildQuickLoginOptions() {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is SavedCredentialsLoaded && state.hasPassword) {
//           return Column(
//             children: [
//               const Divider(
//                 color: Color.fromARGB(255, 148, 145, 146),
//                 thickness: 0.5,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Quick Login',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Color.fromARGB(255, 148, 145, 146),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Login with saved credentials
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       context.read<AuthBloc>().add(
//                             const LoginWithSavedCredentialsRequested(),
//                           );
//                     },
//                     icon: const Icon(
//                       Icons.login,
//                       size: 18,
//                       color: Colors.white,
//                     ),
//                     label: const Text(
//                       'Saved Login',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(162, 12, 13, 0.8),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//
//                   // Biometric login (if available and enabled)
//                   if (_biometricAvailable && _biometricEnabled)
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         context.read<AuthBloc>().add(
//                               const LoginWithSavedCredentialsRequested(
//                                 useBiometric: true,
//                               ),
//                             );
//                       },
//                       icon: const Icon(
//                         Icons.fingerprint,
//                         size: 18,
//                         color: Colors.white,
//                       ),
//                       label: const Text(
//                         'Biometric',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.white,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromRGBO(162, 12, 13, 0.8),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//
//               // Clear saved credentials option
//               TextButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Clear Saved Credentials'),
//                       content: const Text(
//                         'Are you sure you want to clear your saved login credentials?',
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.of(context).pop(),
//                           child: const Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             context.read<AuthBloc>().add(
//                                   ClearSavedCredentialsRequested(),
//                                 );
//                           },
//                           child: const Text(
//                             'Clear',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Clear saved credentials',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Color.fromARGB(255, 148, 145, 146),
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

class LoginFormContent extends StatefulWidget {
  final VoidCallback? onSignUpPressed;

  const LoginFormContent({super.key, this.onSignUpPressed});

  @override
  State<LoginFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<LoginFormContent> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _saveCredentials = false;
  bool _keepSignedIn = false;
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
    // _checkBiometricAvailability();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadSavedCredentials() {
    context.read<AuthBloc>().add(LoadSavedCredentialsRequested());
  }

  // void _checkBiometricAvailability() async {
  //   // final available = await BiometricService.isBiometricAvailable();
  //   if (mounted) {
  //     setState(() {
  //       _biometricAvailable = available;
  //     });
  //   }
  // }

  void _showBiometricLoginDialog() {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.biometricLogin),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fingerprint,
              size: 64,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(l10n.useBiometricAuth),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(
                const LoginWithSavedCredentialsRequested(
                    useBiometric: true),
              );
            },
            child: Text(l10n.authenticate),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          AwesomeDialog(
            context: context,
            transitionAnimationDuration: const Duration(milliseconds: 500),
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            headerAnimationLoop: false,
            title: l10n.error,
            desc: state.error,
            btnOkOnPress: () {},
            buttonsBorderRadius: BorderRadius.circular(0),
            btnOkColor: Colors.red,
            buttonsTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ).show();
        } else if (state is AuthSuccess || state is AuthAuthenticated) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ),
          );
        } else if (state is SavedCredentialsLoaded) {
          setState(() {
            _phoneController.text = state.phone;
            _saveCredentials = state.hasPassword;
            // _biometricEnabled = state.biometricEnabled;
            // _biometricAvailable = state.biometricAvailable;
          });
        } else if (state is BiometricAuthenticationRequired) {
          _showBiometricLoginDialog();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    l10n.login,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.letsGetStarted,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 148, 145, 146),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Phone Number Field
                  CustomRegisterTextField(
                    controller: _phoneController,
                    label: l10n.phoneNumber,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validateSyrianPhone,
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CustomRegisterTextField(
                    controller: _passwordController,
                    label: l10n.password,
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.text,
                    validator: Validators.validatePassword,
                    validateOnChange: true,
                    suffixIcon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onSuffixPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                  const SizedBox(height: 20),

                  // Security Options
                  _buildSecurityOptions(l10n),

                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestSecurityQuestionPage(),
                        ),
                      ),
                      child: Text(
                        l10n.forgotPassword,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 148, 145, 146),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.screenHeight(context) * 0.04),

                  // Login Button
                  _buildLoginButton(l10n),

                  const SizedBox(height: 10),

                  // Quick Login Options
                  _buildQuickLoginOptions(l10n),

                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.dontHaveAccount,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 148, 145, 146),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.onSignUpPressed != null) {
                            widget.onSignUpPressed!();
                          }
                        },
                        child: Text(
                          l10n.signUp,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(162, 12, 13, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.screenHeight(context) * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOptions(AppLocalizations l10n) {
    return Column(
      children: [
        // Save Password Option
        Row(
          children: [
            Checkbox(
              value: _saveCredentials,
              onChanged: (value) {
                setState(() {
                  _saveCredentials = value ?? false;
                  if (!_saveCredentials) {
                    _biometricEnabled = false;
                  }
                });
              },
              activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
            ),
            Expanded(
              child: Text(
                l10n.saveMyPasswordSecurely,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 148, 145, 146),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        // Keep Signed In Option
        Row(
          children: [
            Checkbox(
              value: _keepSignedIn,
              onChanged: (value) {
                setState(() {
                  _keepSignedIn = value ?? false;
                });
              },
              activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
            ),
            Expanded(
              child: Text(
                l10n.keepMeSignedIn,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 148, 145, 146),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        // Biometric Authentication Option
        if (_biometricAvailable && _saveCredentials)
          Row(
            children: [
              Checkbox(
                value: _biometricEnabled,
                onChanged: (value) {
                  setState(() {
                    _biometricEnabled = value ?? false;
                  });
                  context.read<AuthBloc>().add(
                    UpdateBiometricPreferenceRequested(_biometricEnabled),
                  );
                },
                activeColor: const Color.fromRGBO(162, 12, 13, 1.0),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.fingerprint,
                      size: 16,
                      color: Color.fromARGB(255, 148, 145, 146),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.enableBiometricLogin,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 148, 145, 146),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildLoginButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(162, 12, 13, 1.0),
            ),
          );
        }
        return SizedBox(
          width: AppSizes.screenWidth(context),
          height: AppSizes.screenHeight(context) * 0.07,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            onPressed: () {
              // Validate input before sending
              if (_phoneController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.pleaseEnterPhoneNumber),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (_passwordController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.pleaseEnterPassword),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              context.read<AuthBloc>().add(
                LoginWithPhoneRequested(
                  _phoneController.text.trim(),
                  _passwordController.text.trim(),
                  saveCredentials: _saveCredentials,
                  keepSignedIn: _keepSignedIn,
                ),
              );
            },
            child: Text(
              l10n.signIn,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickLoginOptions(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is SavedCredentialsLoaded && state.hasPassword) {
          return Column(
            children: [
              const Divider(
                color: Color.fromARGB(255, 148, 145, 146),
                thickness: 0.5,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.quickLogin,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 148, 145, 146),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Login with saved credentials
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const LoginWithSavedCredentialsRequested(),
                      );
                    },
                    icon: const Icon(
                      Icons.login,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      l10n.savedLogin,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(162, 12, 13, 0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  // Biometric login (if available and enabled)
                  if (_biometricAvailable && _biometricEnabled)
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          const LoginWithSavedCredentialsRequested(
                            useBiometric: true,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.fingerprint,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: Text(
                        l10n.biometric,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(162, 12, 13, 0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Clear saved credentials option
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.clearSavedCredentialsTitle),
                      content: Text(l10n.clearSavedCredentialsMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.read<AuthBloc>().add(
                              ClearSavedCredentialsRequested(),
                            );
                          },
                          child: Text(
                            l10n.clear,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  l10n.clearSavedCredentials,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 148, 145, 146),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

//TODO : VERSION 2
// // Updated LoginFormContent with secure token management
// class LoginFormContent extends StatefulWidget {
//   final VoidCallback? onSignUpPressed;
//
//   const LoginFormContent({super.key, this.onSignUpPressed});
//
//   @override
//   State<LoginFormContent> createState() => _LoginFormContentState();
// }
//
// class _LoginFormContentState extends State<LoginFormContent> {
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _showPassword = false;
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           AwesomeDialog(
//             context: context,
//             transitionAnimationDuration: const Duration(milliseconds: 500),
//             dialogType: DialogType.error,
//             animType: AnimType.bottomSlide,
//             headerAnimationLoop: false,
//             title: 'Error',
//             desc: state.error,
//             btnOkOnPress: () {},
//             buttonsBorderRadius: BorderRadius.circular(0),
//             btnOkColor: Colors.red,
//             buttonsTextStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//             ),
//           ).show();
//         } else if (state is AuthSuccess || state is AuthAuthenticated) {
//           // Navigate to next screen after successful login
//           Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const BulletinPostPage(scheduleSlotId: 281),
//             ),
//           );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => const CreateLessonComboPage(),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => MultiBlocProvider(
//           //       providers: [
//           //         BlocProvider(create: (context) => getIt<LessonsBloc>()),
//           //         BlocProvider(create: (context) => getIt<HomeworkBloc>()),
//           //       ],
//           //       child: const LessonsPage(scheduleSlotId: 281),
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<QuizListBloc>(),
//           //       child: const QuizListPage(
//           //         scheduleSlotId: 281,
//           //       ), // Replace with actual schedule slot ID
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => const NewsFeedWrapper(
//           //       scheduleSlotId: 281,
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => MultiBlocProvider(
//           //       providers: [
//           //         BlocProvider(create: (context) => getIt<QuizListBloc>()),
//           //         BlocProvider(create: (context) => getIt<QuizAttemptBloc>()),
//           //         BlocProvider(create: (context) => getIt<QuizQuestionsBloc>()),
//           //       ],
//           //       child: const QuizListPage(
//           //         scheduleSlotId: 281,
//           //       ),
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<LessonsBloc>(),
//           //       // or your DI method
//           //       child: const LessonsPage(
//           //         scheduleSlotId: 281,
//           //       ),
//           //     ),
//           //   ),
//           // );
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => OnboardingBloc(
//           //         prefs: getIt<SharedPreferences>(),
//           //       )..add(CheckOnboardingStatusEvent()),
//           //       child: const OnboardingScreen(),
//           //     ),
//           //   ),
//           // );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(45),
//                 topRight: Radius.circular(45),
//               ),
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Color.fromRGBO(162, 12, 13, 1.0),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "let's get started",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromARGB(255, 148, 145, 146),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   CustomRegisterTextField(
//                     controller: _phoneController,
//                     label: 'Phone Number',
//                     keyboardType: TextInputType.phone,
//                     validator: Validators.validateSyrianPhone,
//                   ),
//                   const SizedBox(height: 20),
//                   CustomRegisterTextField(
//                     controller: _passwordController,
//                     label: 'Password',
//                     obscureText: !_showPassword,
//                     keyboardType: TextInputType.text,
//                     validator: Validators.validatePassword,
//                     validateOnChange: true,
//                     suffixIcon: Icon(
//                       _showPassword ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onSuffixPressed: () =>
//                         setState(() => _showPassword = !_showPassword),
//                   ),
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RequestSecurityQuestionPage(),
//                         ),
//                       ),
//                       child: const Text(
//                         "forgot password ?",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                   BlocBuilder<AuthBloc, AuthState>(
//                     builder: (context, state) {
//                       if (state is AuthLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(
//                             color: Color.fromRGBO(162, 12, 13, 1.0),
//                           ),
//                         );
//                       }
//                       return SizedBox(
//                         width: AppSizes.screenWidth(context),
//                         height: AppSizes.screenHeight(context) * 0.07,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(1),
//                             ),
//                           ),
//                           onPressed: () {
//                             // Validate input before sending
//                             if (_phoneController.text.trim().isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content:
//                                       Text('Please enter your phone number'),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                               return;
//                             }
//
//                             if (_passwordController.text.trim().isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Please enter your password'),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                               return;
//                             }
//
//                             context.read<AuthBloc>().add(
//                                   LoginWithPhoneRequested(
//                                     _phoneController.text.trim(),
//                                     _passwordController.text.trim(),
//                                   ),
//                                 );
//                           },
//                           child: const Text(
//                             'LOGIN',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Don\'t have an account ?',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (widget.onSignUpPressed != null) {
//                             widget.onSignUpPressed!();
//                           }
//                         },
//                         child: const Text(
//                           ' SIGN UP',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color.fromRGBO(162, 12, 13, 1.0),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.03),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//TODO : VERSION 1
//
// class LoginFormContent extends StatefulWidget {
//   final VoidCallback? onSignUpPressed; // Add this
//   const LoginFormContent({super.key, this.onSignUpPressed});
//
//   @override
//   State<LoginFormContent> createState() => _LoginFormContentState();
// }
//
// class _LoginFormContentState extends State<LoginFormContent> {
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _showPassword = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           AwesomeDialog(
//             context: context,
//             transitionAnimationDuration: const Duration(milliseconds: 500),
//             // autoHide: const Duration(seconds: 6),
//             dialogType: DialogType.error,
//             animType: AnimType.bottomSlide,
//             headerAnimationLoop: false,
//             title: 'Error',
//             desc: state.error,
//             btnOkOnPress: () {},
//             buttonsBorderRadius: BorderRadius.circular(0),
//             // btnOkIcon: Icons.cancel,
//             btnOkColor: Colors.red,
//             buttonsTextStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//             ),
//           ).show();
//         } else if (state is AuthSuccess) {
//           Navigator.pop(context); // Close modal first
//           // Navigation from login form:
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<ProfileBloc>(),
//           //       // or your DI method
//           //       child: ProfilePage(),
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<ProfileImageBloc>(), // or your DI method
//           //       child: const ProfileImagesDisplayPage(),
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<ProfileImageBloc>(), // or your DI method
//           //       child: const ProfileImageUploadPage(),
//           //     ),
//           //   ),
//           // );
//           // Navigate to the deposit request page
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => DepositRequestPage(
//           //       depositMethodId: 1, // Pass from previous page
//           //     ),
//           //   ),
//           // );
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<WishlistBloc>(), // or your DI method
//           //       child: const WishlistPage(),
//           //     ),
//           //   ),
//           // );
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //       create: (context) => getIt<CreateProfileBloc>(),
//           //       child: const CreateProfileBasicInfoPage(),
//           //     ),
//           //   ),
//           // );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               // builder: (context) => ProfilePage(),
//               builder: (context) => BlocProvider(
//                 create: (context) => OnboardingBloc(
//                   prefs: getIt<SharedPreferences>(),
//                 )..add(CheckOnboardingStatusEvent()),
//                 child: const OnboardingScreen(),
//               ),
//             ),
//           );
//         }
//       },
//
//       // },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(45),
//                   topRight: Radius.circular(45),
//                 ),
//                 color: Colors.white),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Color.fromRGBO(162, 12, 13, 1.0),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "let's get started",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromARGB(255, 148, 145, 146),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   // AuthTextField(
//                   //   textEditingController: _phoneController,
//                   //   obscureText: false,
//                   //   labelText: "Phone Number",
//                   //   textInputType: TextInputType.phone,
//                   // ),
//                   CustomRegisterTextField(
//                     controller: _phoneController,
//                     label: 'Phone Number',
//                     keyboardType: TextInputType.phone,
//                     validator: Validators.validateSyrianPhone,
//                   ),
//
//                   const SizedBox(height: 20),
//                   CustomRegisterTextField(
//                     controller: _passwordController,
//                     label: 'Password',
//                     obscureText: !_showPassword,
//                     keyboardType: TextInputType.text,
//                     validator: Validators.validatePassword,
//                     validateOnChange: true,
//                     suffixIcon: Icon(
//                       _showPassword ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onSuffixPressed: () =>
//                         setState(() => _showPassword = !_showPassword),
//                   ),
//                   // CustomRegisterTextField(
//                   //   controller: _passwordController,
//                   //   label: 'Password',
//                   //   obscureText: true,
//                   //   keyboardType: TextInputType.text,
//                   //   validator: Validators.validatePassword,
//                   // ),
//                   // AuthTextField(
//                   //   textEditingController: _passwordController,
//                   //   obscureText: true,
//                   //   labelText: "Password",
//                   //   textInputType: TextInputType.text,
//                   // ),
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RequestSecurityQuestionPage(),
//                         ),
//                       ),
//                       child: const Text(
//                         "forgot password ?",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                   BlocBuilder<AuthBloc, AuthState>(
//                     builder: (context, state) {
//                       if (state is AuthLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       return SizedBox(
//                         width: AppSizes.screenWidth(context),
//                         height: AppSizes.screenHeight(context) * 0.07,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                 1,
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             context.read<AuthBloc>().add(
//                                   LoginWithPhoneRequested(
//                                     _phoneController.text.trim(),
//                                     _passwordController.text.trim(),
//                                   ),
//                                 );
//                           },
//                           child: const Text(
//                             'LOGIN',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Don\'t have an account ?',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 148, 145, 146),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       GestureDetector(
//                         // onTap: () {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => RegisterPage(),
//                         //     ),
//                         //   );
//                         // },
//                         onTap: () {
//                           if (widget.onSignUpPressed != null) {
//                             widget.onSignUpPressed!(); // Trigger the callback
//                           }
//                         },
//                         child: const Text(
//                           ' SIGN UP',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color.fromRGBO(162, 12, 13, 1.0),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: AppSizes.screenHeight(context) * 0.03),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
