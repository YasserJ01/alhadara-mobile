// auth/presentation/widgets/register_modal.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../dependencies.dart';
import '../../../auth/presentation/bloc/register/register_bloc.dart';
import '../../../auth/presentation/widgets/register_form.dart';

class RegisterModal extends StatelessWidget {
  final VoidCallback? onLoginPressed;

  const RegisterModal({super.key, this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: MediaQuery.of(context).size.width / 23,
            right: MediaQuery.of(context).size.width / 23,
          ),
          child: const SingleChildScrollView(
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}