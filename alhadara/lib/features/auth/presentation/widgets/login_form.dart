// // auth/presentation/widgets/login_form.dart
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

import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/pages/request_security_question_page.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/auth_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../onboarding/bloc/onboarding_bloc.dart';
import '../../../onboarding/screens/onboarding.dart';
import 'custom_register_text_field.dart';

class LoginFormContent extends StatefulWidget {
  final VoidCallback? onSignUpPressed;

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is AuthSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => OnboardingBloc(),
                child: Onboarding(),
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.responsiveSize(context,
              mobile: 12, tablet: 20, desktop: 24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 8, tablet: 16, desktop: 24)),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: AppSizes.responsiveFontSize(context,
                      mobile: 28, tablet: 32, desktop: 36),
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 8, tablet: 12, desktop: 16)),
              Text(
                "let's get started",
                style: TextStyle(
                  fontSize: AppSizes.responsiveFontSize(context,
                      mobile: 12, tablet: 14, desktop: 16),
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 24, tablet: 32, desktop: 40)),
              CustomRegisterTextField(
                controller: _phoneController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: Validators.validateSyrianPhone,
                // contentPadding: EdgeInsets.symmetric(
                //   vertical: AppSizes.responsiveSize(context, mobile: 12, tablet: 16, desktop: 20),
                //   horizontal: AppSizes.responsiveSize(context, mobile: 16, tablet: 20, desktop: 24),
                // ),
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 4, tablet: 20, desktop: 24)),
              AuthTextField(
                textEditingController: _passwordController,
                obscureText: true,
                labelText: "Password",
                textInputType: TextInputType.text,
                // contentPadding: EdgeInsets.symmetric(
                //   vertical: AppSizes.responsiveSize(context, mobile: 12, tablet: 16, desktop: 20),
                //   horizontal: AppSizes.responsiveSize(context, mobile: 16, tablet: 20, desktop: 24),
                // ),
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 16, tablet: 20, desktop: 24)),
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
                    "forgot password ?",
                    style: TextStyle(
                      fontSize: AppSizes.responsiveFontSize(context,
                          mobile: 12, tablet: 14, desktop: 16),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 24, tablet: 32, desktop: 40)),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return AppElevatedButton(
                    child:     state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: AppSizes.responsiveFontSize(context,
                                    mobile: 18, tablet: 20, desktop: 22),
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor,
                              ),
                            ),
                   
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  LoginWithPhoneRequested(
                                    _phoneController.text.trim(),
                                    _passwordController.text.trim(),
                                  ),
                                );
                          },
                  );
                  // SizedBox(
                  //   height: AppSizes.responsiveSize(context,
                  //       mobile: 48, tablet: 56, desktop: 64),
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(1),
                  //       ),
                  //     ),
                  //     onPressed: state is AuthLoading
                  //         ? null
                  //         : () {
                  //             context.read<AuthBloc>().add(
                  //                   LoginWithPhoneRequested(
                  //                     _phoneController.text.trim(),
                  //                     _passwordController.text.trim(),
                  //                   ),
                  //                 );
                  //           },
                  //     child:
                  // state is AuthLoading
                  //         ? const CircularProgressIndicator(color: Colors.white)
                  //         : Text(
                  //             'LOGIN',
                  //             style: TextStyle(
                  //               fontSize: AppSizes.responsiveFontSize(context,
                  //                   mobile: 18, tablet: 20, desktop: 22),
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //   ),
                  // );
                },
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 16, tablet: 20, desktop: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      fontSize: AppSizes.responsiveFontSize(context,
                          mobile: 12, tablet: 14, desktop: 16),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onSignUpPressed,
                    child: Text(
                      ' SIGN UP',
                      style: TextStyle(
                        fontSize: AppSizes.responsiveFontSize(context,
                            mobile: 12, tablet: 14, desktop: 16),
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class LoginFormContent extends StatefulWidget {
//   final VoidCallback? onSignUpPressed; // Add this

//   const LoginFormContent({super.key, this.onSignUpPressed});

//   @override
//   State<LoginFormContent> createState() => _LoginFormContentState();
// }

// class _LoginFormContentState extends State<LoginFormContent> {
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error)),
//           );
//         } else if (state is AuthSuccess) {
//           Navigator.pop(context); // Close modal first
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               // builder: (context) => Onboarding(),
//               builder: (context) => BlocProvider(
//                 create: (context) => OnboardingBloc(),
//                 child: Onboarding(),
//               ),
//             ),
//           );
//         }
//       },
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
//                   const SizedBox(height: 20),
//                   AuthTextField(
//                     textEditingController: _passwordController,
//                     obscureText: true,
//                     labelText: "Password",
//                     textInputType: TextInputType.text,
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
//                         return const CircularProgressIndicator();
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
