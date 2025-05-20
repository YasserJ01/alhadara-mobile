import 'package:alhadara/core/constants/reset_password_scaffold.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/widgets/request_security_question_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestSecurityQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResetPasswordScaffold(
        body: BlocProvider(
      create: (context) => getIt<RequestSecurityQuestionBloc>(),
      child: RequestSecurityQuestionForm(),
    ));
    //  Scaffold(
    //   appBar: AppBar(
    //     leading: Container(
    //       child: IconButton(
    //         onPressed: () {
    //           Navigator.pop(context);

    //           showModalBottomSheet(
    //             context: context,
    //             isScrollControlled: true,
    //             backgroundColor: Colors.transparent,
    //             builder: (context) => const LoginModal(),
    //           );
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
    //     create: (context) => getIt<RequestSecurityQuestionBloc>(),
    //     child: RequestSecurityQuestionForm(),
    //   ),
    // );
  }
}
