// // features/security_question/presentation/widgets/security_question_modal.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../dependencies.dart';
// import '../../domain/usecases/get_security_questions_usecase.dart';
// import '../../domain/usecases/submit_security_answer_usecase.dart';
// import '../bloc/security_question_bloc.dart';
// import '../widgets/security_question_content.dart';

// class SecurityQuestionModal extends StatelessWidget {
//   final String authToken;

//   const SecurityQuestionModal({super.key, required this.authToken});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SecurityQuestionBloc(
//         getSecurityQuestionsUseCase: getIt<GetSecurityQuestionsUseCase>(),
//         submitSecurityAnswerUseCase:
//             getIt<SubmitSecurityAnswerUseCase>(), // Add this
//       )..add(LoadSecurityQuestions(authToken)),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(45),
//             topRight: Radius.circular(45),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 16,
//             right: 16,
//           ),
//           child: SingleChildScrollView(
//             child: SecurityQuestionContent(
//               authToken: authToken,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../../domain/usecases/get_security_questions_usecase.dart';
import '../../domain/usecases/submit_security_answer_usecase.dart';
import '../bloc/security_question_bloc.dart';
import '../widgets/security_question_content.dart';

class SecurityQuestionModal extends StatelessWidget {
  final String authToken;

  const SecurityQuestionModal({super.key, required this.authToken});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecurityQuestionBloc(
        getSecurityQuestionsUseCase: getIt<GetSecurityQuestionsUseCase>(),
        submitSecurityAnswerUseCase: getIt<SubmitSecurityAnswerUseCase>(),
      )..add(LoadSecurityQuestions(authToken)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: AppSizes.screenHeight(context) * 0.55,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.paddingBottom(context),
            left: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
            right: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
            top: AppSizes.responsiveSize(context,
                mobile: 24, tablet: 32, desktop: 40),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SecurityQuestionContent(
              authToken: authToken,
            ),
          ),
        ),
      ),
    );
  }
}
