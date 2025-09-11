// auth/presentation/widgets/register_form.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/captch/captcha_bloc.dart';
import 'dart:typed_data';
import 'dart:convert';
import '../../../../dependencies.dart';
import '../bloc/verification/verification_bloc.dart';
import '../pages/start_verification_page.dart';
import 'captcha_widget.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/utils/validators.dart';
import '../../../security_question/presentation/pages/security_question_modal.dart';
import '../../../start/presentation/widgets/login_modal.dart';
import '../bloc/register/register_bloc.dart';
import 'custom_register_text_field.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback? onLoginPressed;

  const RegisterForm({super.key, this.onLoginPressed});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    'firstName': TextEditingController(),
    'middleName': TextEditingController(),
    'lastName': TextEditingController(),
    'phone': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'captcha': TextEditingController(),
  };

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String? _captchaKey;
  bool _isHumanVerified = false; // حالة التحقق من أن المستخدم إنسان

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Check which bloc instance we're listening to
    final registerBloc = context.read<RegisterBloc>();
    print("Listening to RegisterBloc instance: $registerBloc");

    return MultiBlocProvider(
      providers: [
        // REMOVED: RegisterBloc provider - use the one from parent
        // Only keep CaptchaBloc provider
        BlocProvider(
          create: (context) => getIt<CaptchaBloc>()..add(LoadCaptcha()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterFailure) {
                print("Fail: ${state.error}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is RegisterSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => getIt<VerificationBloc>(),
                      child: const StartVerificationPage(),
                    ),
                  ),
                );
                // print("HI - Success with token: ${state.authToken}");
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   showModalBottomSheet(
                //     context: context,
                //     isScrollControlled: true,
                //     backgroundColor: Colors.transparent,
                //     builder: (context) => const SecurityQuestionModal(),
                //   );
                // });
              }
            },
          ),
          BlocListener<CaptchaBloc, CaptchaState>(
            listener: (context, state) {
              if (state is CaptchaLoaded) {
                setState(() {
                  _captchaKey = state.captcha.key;
                });
              }
            },
          ),
        ],
        child: _buildFormContent(context),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.responsiveSize(context,
            mobile: 16, tablet: 20, desktop: 24)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 16, tablet: 24, desktop: 32)),
              Text(
                "Register",
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
                      mobile: 20, tablet: 28, desktop: 36)),
              CustomRegisterTextField(
                controller: _controllers['firstName']!,
                label: 'First Name',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 2, tablet: 20, desktop: 24)),
              CustomRegisterTextField(
                controller: _controllers['middleName']!,
                label: 'Middle Name',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 2, tablet: 20, desktop: 24)),
              CustomRegisterTextField(
                controller: _controllers['lastName']!,
                label: 'Last Name',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 2, tablet: 20, desktop: 24)),
              CustomRegisterTextField(
                controller: _controllers['phone']!,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: Validators.validateSyrianPhone,
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 2, tablet: 20, desktop: 24)),
              CustomRegisterTextField(
                controller: _controllers['password']!,
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
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 2, tablet: 20, desktop: 24)),
              CustomRegisterTextField(
                controller: _controllers['confirmPassword']!,
                label: 'Confirm Password',
                obscureText: !_showConfirmPassword,
                validator: (value) {
                  if (value != _controllers['password']!.text) {
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
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 20, tablet: 28, desktop: 36)),
              // CAPTCHA Verification Checkbox
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isHumanVerified ? Colors.green : Colors.grey[300]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: _isHumanVerified ? Colors.green[50] : Colors.grey[50],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isHumanVerified,
                      onChanged: (value) async {
                        if (value == true) {
                          final result = await _showCaptchaDialog(context);
                          if (result != null) {
                            setState(() {
                              _isHumanVerified = true;
                              _captchaKey = result['key'];
                              _controllers['captcha']!.text =
                                  result['answer'] ?? '';
                            });
                          }
                        } else {
                          setState(() {
                            _isHumanVerified = false;
                            _captchaKey = null;
                            _controllers['captcha']!.text = '';
                          });
                        }
                      },
                      activeColor: AppColors.mainColor,
                    ),
                    Text(
                      "I'm human",
                      style: TextStyle(
                        fontSize: 16,
                        color: _isHumanVerified
                            ? Colors.green[800]
                            : Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_isHumanVerified) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.verified, color: Colors.green[700], size: 18),
                    ],
                  ],
                ),
              ),
              if (!_isHumanVerified)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text(
                    "Please verify that you're human to continue",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red[700],
                    ),
                  ),
                ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 20, tablet: 28, desktop: 36)),
              // Register Button
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppElevatedButton(
                    onPressed: (state is RegisterLoading || !_isHumanVerified)
                        ? null
                        : _submitForm,
                    child: state is RegisterLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 18, tablet: 20, desktop: 22),
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  );
                },
              ),
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 16, tablet: 20, desktop: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      fontSize: AppSizes.responsiveFontSize(context,
                          mobile: 12, tablet: 14, desktop: 16),
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onLoginPressed,
                    child: Text(
                      'LOGIN',
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
              SizedBox(
                  height: AppSizes.responsiveSize(context,
                      mobile: 16, tablet: 20, desktop: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>?> _showCaptchaDialog(BuildContext context) async {
    return await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verify you're human",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Complete the CAPTCHA to continue",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                BlocProvider(
                  create: (dialogContext) =>
                      getIt<CaptchaBloc>()..add(LoadCaptcha()),
                  child: CaptchaWidget(
                    captchaController: TextEditingController(),
                    captchaKey: _captchaKey,
                    onVerified: (key, answer) {
                      Navigator.of(dialogContext).pop({
                        'key': key,
                        'answer': answer,
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _captchaKey != null &&
        _isHumanVerified) {
      final registerBloc = context.read<RegisterBloc>();
      print("Dispatching to RegisterBloc instance: $registerBloc");

      registerBloc.add(
        RegisterRequested(
          firstName: _controllers['firstName']!.text.trim(),
          middleName: _controllers['middleName']!.text.trim(),
          lastName: _controllers['lastName']!.text.trim(),
          phone: _controllers['phone']!.text.trim(),
          password: _controllers['password']!.text.trim(),
          confirm_password: _controllers['confirmPassword']!.text.trim(),
          captchaKey: _captchaKey!,
          captchaAnswer: _controllers['captcha']!.text.trim(),
        ),
      );
    }
  }
}
