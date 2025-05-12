// auth/presentation/widgets/register_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/utils/validators.dart';
import '../../../start/presentation/widgets/login_modal.dart';
import '../bloc/register/register_bloc.dart';
import 'custom_register_text_field.dart';

// class RegisterForm extends StatefulWidget {
//   final VoidCallback? onLoginPressed;
//
//   const RegisterForm({super.key, this.onLoginPressed});
//
//   @override
//   _RegisterFormState createState() => _RegisterFormState();
// }
//
// class _RegisterFormState extends State<RegisterForm> {
//   final _firstNameController = TextEditingController();
//   final _middleNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<RegisterBloc, RegisterState>(
//       listener: (context, state) {
//         if (state is RegisterFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error)),
//           );
//         } else if (state is RegisterSuccess) {
//           // Navigate to login or home screen
//           Navigator.pop(context); // Go back to login
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
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _firstNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'First Name'),
//                     ),
//                     TextField(
//                       controller: _middleNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'Middle Name'),
//                     ),
//                     TextField(
//                       controller: _lastNameController,
//                       decoration: const InputDecoration(labelText: 'Last Name'),
//                     ),
//                     TextField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration:
//                           const InputDecoration(labelText: 'Phone Number'),
//                     ),
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty)
//                           return 'Enter password';
//                         if (value.length < 6)
//                           return 'Password must be at least 6 characters';
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       decoration:
//                           const InputDecoration(labelText: 'Confirm Password'),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value != _passwordController.text)
//                           return 'Passwords do not match';
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     BlocBuilder<RegisterBloc, RegisterState>(
//                       builder: (context, state) {
//                         if (state is RegisterLoading) {
//                           return const CircularProgressIndicator();
//                         }
//                         return ElevatedButton(
//                           onPressed: () {
//                             context.read<RegisterBloc>().add(
//                                   RegisterRequested(
//                                     firstName: _firstNameController.text.trim(),
//                                     middleName:
//                                         _middleNameController.text.trim(),
//                                     lastName: _lastNameController.text.trim(),
//                                     phone: _phoneController.text.trim(),
//                                     password: _passwordController.text.trim(),
//                                     confirmPassword:
//                                         _confirmPasswordController.text.trim(),
//                                   ),
//                                 );
//                           },
//                           child: const Text('Register'),
//                         );
//                       },
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close register modal
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) => const LoginModal(),
//                         );
//                       },
//                       child: const Text('Already have an account? Login'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
  };

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
        }
      },
      // child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(45),
//               ),
//             ),
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
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Register",
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
                    const SizedBox(height: 20),
                    CustomRegisterTextField(
                      controller: _controllers['firstName']!,
                      label: 'First Name',
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Required field' : null,
                    ),
                    CustomRegisterTextField(
                      controller: _controllers['middleName']!,
                      label: 'Middle Name',
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Required field' : null,
                    ),
                    CustomRegisterTextField(
                      controller: _controllers['lastName']!,
                      label: 'Last Name',
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Required field' : null,
                    ),
                    CustomRegisterTextField(
                      controller: _controllers['phone']!,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: Validators.validateSyrianPhone,
                    ),
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
                    const SizedBox(height: 20),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return const CircularProgressIndicator();
                        }
                        return Center(
                          child: SizedBox(
                            width: AppSizes.screenWidth(context),
                            height: AppSizes.screenHeight(context) * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(162, 12, 13, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    1,
                                  ),
                                ),
                              ),
                              onPressed: _submitForm,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 148, 145, 146),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Close register modal
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const LoginModal(),
                            );
                          },
                          child: const Text(
                            '  Login',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(162, 12, 13, 1.0),
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
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            RegisterRequested(
              firstName: _controllers['firstName']!.text.trim(),
              middleName: _controllers['middleName']!.text.trim(),
              lastName: _controllers['lastName']!.text.trim(),
              phone: _controllers['phone']!.text.trim(),
              password: _controllers['password']!.text.trim(),
              confirmPassword: _controllers['confirmPassword']!.text.trim(),
            ),
          );
    }
  }
}
