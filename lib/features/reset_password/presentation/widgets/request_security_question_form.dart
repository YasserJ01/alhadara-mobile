import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:project2/features/reset_password/presentation/pages/answer_security_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestSecurityQuestionForm extends StatefulWidget {
  @override
  _RequestSecurityQuestionFormState createState() =>
      _RequestSecurityQuestionFormState();
}

class _RequestSecurityQuestionFormState
    extends State<RequestSecurityQuestionForm> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestSecurityQuestionBloc,
        RequestSecurityQuestionState>(
      listener: (context, state) {
        if (state is RequestSecurityQuestionSuccess) {
          // Navigate to answer question page
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AnswerSecurityQuestionPage(
                phoneNumber: state.phoneNumber,
                securityQuestion: state.questions.first,
              ),
            ),
          );
        } else if (state is RequestSecurityQuestionError) {
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
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                      fontSize: 38),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Text(
                  'Enter your phone number to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 134, 129, 130)),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  // color: Color.fromRGBO(162, 12, 13, 1.0),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),),
                  child: ElevatedButton(
                    onPressed: state is RequestSecurityQuestionLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<RequestSecurityQuestionBloc>().add(
                                    PhoneNumberSubmitted(
                                      phoneNumber: _phoneController.text,
                                    ),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    child: state is RequestSecurityQuestionError
                        ? const Center(
                            child: Text('SEND',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          )
                        : state is RequestSecurityQuestionLoading
                            ? const CircularProgressIndicator()
                            : const Center(
                                child: Text('SEND',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                              ),
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
