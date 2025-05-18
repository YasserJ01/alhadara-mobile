import 'package:project2/dependencies.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:project2/features/reset_password/presentation/widgets/request_security_question_form.dart';
import 'package:project2/features/start/presentation/widgets/login_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestSecurityQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const LoginModal(),
              );
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
        create: (context) => getIt<RequestSecurityQuestionBloc>(),
        child: RequestSecurityQuestionForm(),
      ),
    );
  }
}
