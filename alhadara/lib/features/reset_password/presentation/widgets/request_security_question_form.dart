import 'package:alhadara/core/constants/app_elevated_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:alhadara/features/reset_password/presentation/pages/answer_security_question_page.dart';
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
          padding: EdgeInsets.all(AppSizes.responsiveSize(context,
              mobile: 16, tablet: 24, desktop: 32)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 8, tablet: 16, desktop: 24)),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 32, tablet: 36, desktop: 40),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 24, tablet: 32, desktop: 40)),
                Text(
                  'Enter your phone number to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes.responsiveFontSize(context,
                        mobile: 16, tablet: 18, desktop: 20),
                    color: AppColors.greyColor,
                  ),
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 24, tablet: 32, desktop: 40)),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    // contentPadding: EdgeInsets.symmetric(
                    //   vertical: AppSizes.responsiveSize(context,
                    //       mobile: 12, tablet: 16, desktop: 20),
                    //   horizontal: AppSizes.responsiveSize(context,
                    //       mobile: 16, tablet: 20, desktop: 24),
                    // ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: AppSizes.responsiveSize(context,
                        mobile: 32, tablet: 40, desktop: 48)),
                AppElevatedButton(
                  child: state is RequestSecurityQuestionLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'SEND',
                          style: TextStyle(
                              fontSize: AppSizes.responsiveFontSize(context,
                                  mobile: 18, tablet: 20, desktop: 22),
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor),
                        ),
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
                ),
                // SizedBox(
                //   height: AppSizes.responsiveSize(context,
                //       mobile: 56, tablet: 64, desktop: 72),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                //     ),
                //     onPressed:
                // state is RequestSecurityQuestionLoading
                //         ? null
                //         : () {
                //             if (_formKey.currentState!.validate()) {
                //               context.read<RequestSecurityQuestionBloc>().add(
                //                     PhoneNumberSubmitted(
                //                       phoneNumber: _phoneController.text,
                //                     ),
                //                   );
                //             }
                //           },
                //     child:
                // state is RequestSecurityQuestionLoading
                //         ? CircularProgressIndicator(color: Colors.white)
                //         : Text(
                //             'SEND',
                //             style: TextStyle(
                //                 fontSize: AppSizes.responsiveFontSize(context,
                //                     mobile: 18, tablet: 20, desktop: 22),
                //                 fontWeight: FontWeight.w400,
                //                 color: Colors.white),
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
