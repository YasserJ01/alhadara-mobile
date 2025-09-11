// features/security_question/presentation/widgets/security_question_modal.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../../domain/usecases/get_security_questions_usecase.dart';
import '../../domain/usecases/submit_security_answer_usecase.dart';
import '../bloc/security_question_bloc.dart';
import '../widgets/security_question_content.dart';

class SecurityQuestionModal extends StatelessWidget {

  const SecurityQuestionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecurityQuestionBloc(
        getSecurityQuestionsUseCase: getIt<GetSecurityQuestionsUseCase>(),
        submitSecurityAnswerUseCase:
            getIt<SubmitSecurityAnswerUseCase>(), // Add this
      )..add(LoadSecurityQuestions()),
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
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: SecurityQuestionContent(),
          ),
        ),
      ),
    );
  }
}
