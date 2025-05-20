// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alhadara/features/start/presentation/widgets/register_modal.dart';

// import '../../../../dependencies.dart';
// import '../../../auth/presentation/bloc/auth_bloc.dart';
// import '../../../auth/presentation/widgets/login_form.dart';

// class LoginModal extends StatelessWidget {
//   final VoidCallback? onSignUpPressed;

//   const LoginModal({super.key,this.onSignUpPressed});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       // Provide existing AuthBloc if already created
//       create: (context) => getIt<AuthBloc>(),
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
//             left: MediaQuery.of(context).size.width/23,
//             right: MediaQuery.of(context).size.width/23,
//           ),
//           child:  SingleChildScrollView(
//             child: LoginFormContent(
//               onSignUpPressed: () {
//               Navigator.pop(context); // Close login modal
//               showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (context) => const RegisterModal(),
//               );
//             },
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
import 'package:alhadara/features/start/presentation/widgets/register_modal.dart';
import '../../../../dependencies.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/login_form.dart';

class LoginModal extends StatelessWidget {
  final VoidCallback? onSignUpPressed;

  const LoginModal({super.key, this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: AppSizes.screenHeight(context) * 0.6,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: AppSizes.screenHeight(context) * 0.5,
                    ),
                    child: LoginFormContent(
                      onSignUpPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const RegisterModal(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
