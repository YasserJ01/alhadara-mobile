import 'package:project2/features/reset_password/data/models/security_question_model.dart';
import 'package:project2/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_bloc.dart';
import 'package:project2/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_event.dart';
import 'package:project2/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_state.dart';
import 'package:project2/features/reset_password/presentation/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerSecurityQuestionForm extends StatefulWidget {
  final String phoneNumber;
  final SecurityQuestion securityQuestion;

  const AnswerSecurityQuestionForm({
    Key? key,
    required this.phoneNumber,
    required this.securityQuestion,
  }) : super(key: key);

  @override
  _AnswerSecurityQuestionFormState createState() =>
      _AnswerSecurityQuestionFormState();
}

class _AnswerSecurityQuestionFormState
    extends State<AnswerSecurityQuestionForm> {
  final TextEditingController _answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnswerSecurityQuestionBloc,
        AnswerSecurityQuestionState>(
      listener: (context, state) {
        if (state is AnswerSecurityQuestionSuccess) {
          // Navigate to reset password page
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ResetPasswordPage(
                resetToken: state.resetToken.resetToken,
              ),
            ),
          );
        } else if (state is AnswerSecurityQuestionError) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Security Question",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                      fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  'Answar the question to reset your    password ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 134, 129, 130)),
                ),
                const SizedBox(height: 40),
                Text(
                  'Question : ' + widget.securityQuestion.questionText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    labelText: 'Your Answer',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your answer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ElevatedButton(
                    onPressed: state is AnswerSecurityQuestionLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AnswerSecurityQuestionBloc>().add(
                                    SecurityAnswerSubmitted(
                                      phoneNumber: widget.phoneNumber,
                                      questionId: widget.securityQuestion.id,
                                      answer: _answerController.text,
                                    ),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                    ),
                    child: state is AnswerSecurityQuestionLoading
                        ? CircularProgressIndicator()
                        : Text('Submit',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
