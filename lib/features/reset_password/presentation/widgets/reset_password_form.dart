import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:project2/core/utils/validators.dart';
import 'package:project2/features/auth/presentation/widgets/custom_register_text_field.dart';
import 'package:project2/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:project2/features/reset_password/presentation/bloc/new_password/new_password_event.dart';
import 'package:project2/features/reset_password/presentation/bloc/new_password/new_password_state.dart';
import 'package:project2/features/start/presentation/pages/start_page.dart';
import 'package:project2/features/start/presentation/widgets/login_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Password reset successful!')),
          // );
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'SUCCESS',
            desc: 'You can login now !',
            headerAnimationLoop: false,
            transitionAnimationDuration: const Duration(milliseconds: 500),
            autoHide: const Duration(seconds: 6), // Auto-hide after 2 seconds
            onDismissCallback: (type) {
              // This callback runs when dialog is dismissed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => StartPage()),
                ),
              );
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const LoginModal(),
              );
            },
          ).show();
          // Navigate to login page or home page

        } else if (state is ResetPasswordError) {
          print(state);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Set New Password",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(162, 12, 13, 1.0),
                        fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomRegisterTextField(
                    controller: _newPasswordController!,
                    label: 'Password',
                    obscureText: !_showPassword,
                    validator: Validators.validatePassword,
                    validateOnChange: true,
                    suffixIcon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onSuffixPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                  const SizedBox(height: 16,),
                  CustomRegisterTextField(
                    controller: _confirmPasswordController!,
                    label: 'Confirm Password',
                    obscureText: !_showConfirmPassword,
                    validator: (value) {
                      if (value != _newPasswordController!.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    validateOnChange: true,
                    suffixIcon: Icon(
                      _showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onSuffixPressed: () => setState(
                            () => _showConfirmPassword = !_showConfirmPassword),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
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
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: ((context) => StartPage()),
                              //   ),
                              // );
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   backgroundColor: Colors.transparent,
                              //   builder: (context) => const LoginModal(),
                              // );
                            },
                      child: state is ResetPasswordLoading
                          ? CircularProgressIndicator()
                          : Text('Reset Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
