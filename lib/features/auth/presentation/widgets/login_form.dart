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
import 'package:project2/features/profile/presentation/bloc/view_profile/profile_bloc.dart';
import 'package:project2/features/reset_password/presentation/pages/request_security_question_page.dart';
import 'package:project2/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/utils/validators.dart';
import '../../../../dependencies.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
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
import '../../../wishlist/presentation/pages/wishlist_page.dart';
import 'custom_register_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginFormContent extends StatefulWidget {
  final VoidCallback? onSignUpPressed; // Add this
  const LoginFormContent({super.key, this.onSignUpPressed});

  @override
  State<LoginFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<LoginFormContent> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          AwesomeDialog(
            context: context,
            transitionAnimationDuration: const Duration(milliseconds: 500),
            // autoHide: const Duration(seconds: 6),
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            headerAnimationLoop: false,
            title: 'Error',
            desc: state.error,
            btnOkOnPress: () {},
            buttonsBorderRadius: BorderRadius.circular(0),
            // btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
            buttonsTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ).show();
        } else if (state is AuthSuccess) {
          Navigator.pop(context); // Close modal first
          // Navigation from login form:
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //       create: (context) => getIt<ProfileBloc>(),
          //       // or your DI method
          //       child: ProfilePage(),
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //       create: (context) => getIt<ProfileImageBloc>(), // or your DI method
          //       child: const ProfileImagesDisplayPage(),
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //       create: (context) => getIt<ProfileImageBloc>(), // or your DI method
          //       child: const ProfileImageUploadPage(),
          //     ),
          //   ),
          // );
          // Navigate to the deposit request page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DepositRequestPage(
          //       depositMethodId: 1, // Pass from previous page
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //       create: (context) => getIt<WishlistBloc>(), // or your DI method
          //       child: const WishlistPage(),
          //     ),
          //   ),
          // );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //       create: (context) => getIt<CreateProfileBloc>(),
          //       child: const CreateProfileBasicInfoPage(),
          //     ),
          //   ),
          // );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              // builder: (context) => ProfilePage(),
              builder: (context) => BlocProvider(
                create: (context) => OnboardingBloc(
                  prefs: getIt<SharedPreferences>(),
                )..add(CheckOnboardingStatusEvent()),
                child: const OnboardingScreen(),
              ),
            ),
          );
        }


      },

      // },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "let's get started",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 148, 145, 146),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // AuthTextField(
                  //   textEditingController: _phoneController,
                  //   obscureText: false,
                  //   labelText: "Phone Number",
                  //   textInputType: TextInputType.phone,
                  // ),
                  CustomRegisterTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    validator: Validators.validateSyrianPhone,
                  ),

                  const SizedBox(height: 20),
                  CustomRegisterTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: Validators.validatePassword,
                  ),
                  // AuthTextField(
                  //   textEditingController: _passwordController,
                  //   obscureText: true,
                  //   labelText: "Password",
                  //   textInputType: TextInputType.text,
                  // ),
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
                      child: const Text(
                        "forgot password ?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 148, 145, 146),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                        width: AppSizes.screenWidth(context),
                        height: AppSizes.screenHeight(context) * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  LoginWithPhoneRequested(
                                    _phoneController.text.trim(),
                                    _passwordController.text.trim(),
                                  ),
                                );
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 148, 145, 146),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => RegisterPage(),
                        //     ),
                        //   );
                        // },
                        onTap: () {
                          if (widget.onSignUpPressed != null) {
                            widget.onSignUpPressed!(); // Trigger the callback
                          }
                        },
                        child: const Text(
                          ' SIGN UP',
                          style: TextStyle(
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

}
