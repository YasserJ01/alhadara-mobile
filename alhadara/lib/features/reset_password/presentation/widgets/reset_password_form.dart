import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_event.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ResetPasswordForm extends StatefulWidget {
//   final String resetToken;

//   const ResetPasswordForm({Key? key, required this.resetToken})
//       : super(key: key);

//   @override
//   _ResetPasswordFormState createState() => _ResetPasswordFormState();
// }

// class _ResetPasswordFormState extends State<ResetPasswordForm> {
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void dispose() {
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
//       listener: (context, state) {
//         if (state is ResetPasswordSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Password reset successful!')),
//           );
//           // Navigate to login page or home page
//           Navigator.of(context).popUntil((route) => route.isFirst);
//         } else if (state is ResetPasswordError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 8),
//                 Text(
//                   "Set New Password",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Color.fromRGBO(162, 12, 13, 1.0),
//                       fontSize: 32),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 TextFormField(
//                   controller: _newPasswordController,
//                   decoration: InputDecoration(
//                     labelText: 'New Password',
//                     border: OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   obscureText: _obscurePassword,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your new password';
//                     }
//                     if (value.length < 8) {
//                       return 'Password must be at least 8 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureConfirmPassword
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                         });
//                       },
//                     ),
//                   ),
//                   obscureText: _obscureConfirmPassword,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     if (value != _newPasswordController.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 40),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
//                     ),
//                     onPressed: state is ResetPasswordLoading
//                         ? null
//                         : () {
//                             if (_formKey.currentState!.validate()) {
//                               context.read<ResetPasswordBloc>().add(
//                                     PasswordsSubmitted(
//                                       resetToken: widget.resetToken,
//                                       newPassword: _newPasswordController.text,
//                                       confirmPassword:
//                                           _confirmPasswordController.text,
//                                     ),
//                                   );
//                             }
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: ((context) => StartPage()),
//                               ),
//                             );
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               backgroundColor: Colors.transparent,
//                               builder: (context) => const LoginModal(),
//                             );
//                           },
//                     child: state is ResetPasswordLoading
//                         ? CircularProgressIndicator()
//                         : Text('Reset Password',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class ResetPasswordForm extends StatefulWidget {
  final String resetToken;

  const ResetPasswordForm({Key? key, required this.resetToken})
      : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset successful!')),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(AppSizes.responsiveSize(context,
              mobile: 16, tablet: 24, desktop: 32)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 8, tablet: 16, desktop: 24)),
                Text(
                  "Set New Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 32, tablet: 36, desktop: 40),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 24, tablet: 32, desktop: 40)),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                    // contentPadding: EdgeInsets.symmetric(
                    //   vertical: AppSizes.responsiveSize(context, mobile: 12, tablet: 16, desktop: 20),
                    //   horizontal: AppSizes.responsiveSize(context, mobile: 16, tablet: 20, desktop: 24),
                    // ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 16, tablet: 24, desktop: 32)),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    // contentPadding: EdgeInsets.symmetric(
                    //   vertical: AppSizes.responsiveSize(context, mobile: 12, tablet: 16, desktop: 20),
                    //   horizontal: AppSizes.responsiveSize(context, mobile: 16, tablet: 20, desktop: 24),
                    // ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 32, tablet: 40, desktop: 48)),
                AppElevatedButton(
                  child: state is ResetPasswordLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'RESET PASSWORD',
                          style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 18, tablet: 20, desktop: 22),
                              fontWeight: FontWeight.w400,
                              color:AppColors.whiteColor),
                        ),
                  onPressed: state is ResetPasswordLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ResetPasswordBloc>().add(
                                  PasswordsSubmitted(
                                    resetToken: widget.resetToken,
                                    newPassword: _newPasswordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  ),
                                );
                          }
                        },
                )
                // SizedBox(
                //   height: AppSizes.responsiveSize(context,
                //       mobile: 56, tablet: 64, desktop: 72),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                //     ),
                //     onPressed:
                //state is ResetPasswordLoading
                //         ? null
                //         : () {
                //             if (_formKey.currentState!.validate()) {
                //               context.read<ResetPasswordBloc>().add(
                //                     PasswordsSubmitted(
                //                       resetToken: widget.resetToken,
                //                       newPassword: _newPasswordController.text,
                //                       confirmPassword:
                //                           _confirmPasswordController.text,
                //                     ),
                //                   );
                //             }
                //           },
                //     child:
                // state is ResetPasswordLoading
                //         ? CircularProgressIndicator(color: Colors.white)
                //         : Text(
                //             'RESET PASSWORD',
                //             style: TextStyle(
                //                 fontSize: AppSizes.responsiveFontSize(context,
                //                     mobile: 18, tablet: 20, desktop: 22),
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.white),
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
