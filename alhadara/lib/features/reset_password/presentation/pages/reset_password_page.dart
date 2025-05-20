import 'package:alhadara/core/constants/reset_password_scaffold.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  final String resetToken;

  const ResetPasswordPage({Key? key, required this.resetToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResetPasswordScaffold(
        body: BlocProvider(
      create: (context) => getIt<ResetPasswordBloc>(),
      child: ResetPasswordForm(resetToken: resetToken),
    ));
    // Scaffold(
    //   appBar: AppBar(
    //     leading: Container(
    //       child: IconButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         icon: Icon(
    //           Icons.arrow_back,
    //           size: 40,
    //           color: Color.fromRGBO(162, 12, 13, 1.0),
    //         ),
    //       ),
    //     ),
    //     backgroundColor: Colors.transparent,
    //     shadowColor: Colors.transparent,
    //   ),
    //   body: BlocProvider(
    //     create: (context) => getIt<ResetPasswordBloc>(),
    //     child: ResetPasswordForm(resetToken: resetToken),
    //   ),
    // );
  }
}
