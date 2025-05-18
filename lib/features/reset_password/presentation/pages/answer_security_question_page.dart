import 'package:project2/dependencies.dart';
import 'package:project2/features/reset_password/data/models/security_question_model.dart';
import 'package:project2/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_bloc.dart';
import 'package:project2/features/reset_password/presentation/widgets/answer_security_question_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerSecurityQuestionPage extends StatelessWidget {
  final String phoneNumber;
  final SecurityQuestion securityQuestion;

  const AnswerSecurityQuestionPage({
    Key? key,
    required this.phoneNumber,
    required this.securityQuestion,
  }) : super(key: key);

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
        create: (context) => getIt<AnswerSecurityQuestionBloc>(),
        child: AnswerSecurityQuestionForm(
          phoneNumber: phoneNumber,
          securityQuestion: securityQuestion,
        ),
      ),
    );
  }
}
