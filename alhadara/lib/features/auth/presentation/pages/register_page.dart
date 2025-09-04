// auth/presentation/pages/register_page.dart
import 'package:flutter/material.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterForm(),
    );
  }
}