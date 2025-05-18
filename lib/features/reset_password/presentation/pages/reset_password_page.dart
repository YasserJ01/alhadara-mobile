import 'package:project2/dependencies.dart';
import 'package:project2/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:project2/features/reset_password/presentation/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  final String resetToken;

  const ResetPasswordPage({Key? key, required this.resetToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 40,
              color: Color.fromRGBO(162, 12, 13, 1.0),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => getIt<ResetPasswordBloc>(),
        child: ResetPasswordForm(resetToken: resetToken),
      ),
    );
  }
}
